//
//  MDPullDrivenInteractiveTransition.swift
//  XboxSchedule
//
//  Created by MarvinChan on 2020/8/14.
//

import UIKit

/// 滑动关闭
class MDPullDrivenInteractiveTransition: MDPercentDrivenInteractiveTransition {
    
    // 停顿点
    var stickyPoints: [CGFloat] = []
    ///
    private var offsetY: CGFloat = 0
    /// 记录内部控制的初始位置
    private var originY: CGFloat {
        return controller?.view.frame.origin.y ?? 0
    }
    
    /// 最小的停顿点
    private var minStickyPoint: CGFloat {
        return stickyPoints.min() ?? 0
    }
    
    /// 最大的停顿点
    private var maxStickyPoint: CGFloat {
        return stickyPoints.max() ?? 0
    }
    /// 控制器
    weak var controller: UIViewController?
    /// 滑动列表
    weak var scrollView: UIScrollView?
    /// 列表的ContentOffsetY
    var scrollViewOffsetY: CGFloat = 0
    
    lazy var panGestr: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handelPanGesture(_:)))
    
    
    init(_ controller: UIViewController,scrollView: UIScrollView? = nil) {
        super.init()
        self.controller = controller
        self.scrollView = scrollView
        prepareGestureRecognizer(controller.view)
        
    }
    
    private func prepareGestureRecognizer(_ inView: UIView) {
        panGestr.delegate = self
        panGestr.cancelsTouchesInView = false
        inView.addGestureRecognizer(panGestr)
        if let scrollV = scrollView {
            panGestr.require(toFail: scrollV.panGestureRecognizer)
            scrollV.panGestureRecognizer.addTarget(self, action: #selector(handelScrollViewPanGesture(_:)))
        }
    }
    
}

extension MDPullDrivenInteractiveTransition: UIGestureRecognizerDelegate {
    
    
    @objc func handelScrollViewPanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let controller = controller else { return }
        guard let scrollView = scrollView else { return }
        let isFullOpened = originY == minStickyPoint
        let translationY = gesture.translation(in: scrollView).y
        let isScrollingDown = gesture.velocity(in: scrollView).y > 0
        let shouldDragViewDown = isScrollingDown && scrollView.contentOffset.y <= 0
        
        let shouldDragViewUp = !isScrollingDown && !isFullOpened
        let shouldDragView = shouldDragViewDown || shouldDragViewUp
        
        if shouldDragView {
            scrollView.bounces = false
            scrollView.setContentOffset(.zero, animated: false)
        }
        
        switch gesture.state {
        case .began:
            offsetY = 0
            scrollViewOffsetY = scrollView.contentOffset.y
        case .changed:
            guard shouldDragView else { break }
            offsetY += translationY
            controller.view.transform = CGAffineTransform.identity.translatedBy(x: 0, y: offsetY)
            gesture.setTranslation(CGPoint(x: 0, y: scrollViewOffsetY), in: scrollView)
        case .ended,.cancelled:
            scrollView.bounces = true
            goToNearestStickyOffset()
        default:
            break
        }
    }
    
    @objc func handelPanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let controller = controller else { return }
        let translationY = gesture.translation(in: gesture.view).y
        switch gesture.state {
        case .began:
            self.interacting = true
            offsetY = 0
            
        case .changed:
            offsetY += translationY
            controller.view.transform = CGAffineTransform.identity.translatedBy(x: 0, y: offsetY)
            gesture.setTranslation(.zero, in: gesture.view)
        case .ended,.cancelled:
            goToNearestStickyOffset()
            self.interacting = false
            
        default:
            break
        }
    }
    
    func goToNearestStickyOffset() {
        guard let controller = controller else { return }
        let stickyOffsetY = getNearestOffset()
        if stickyOffsetY == 0 {
            UIView.animate(withDuration: 0.3) {
                controller.view.transform = .identity
            }
            self.cancel()
        }else if abs(stickyOffsetY) >=  UIScreen.main.bounds.height{
            if let _ = controller.presentingViewController {
                controller.dismiss(animated: true, completion: nil)
            }else {
                controller.view.isHidden = true
            }
            self.finish()
        }else {
            UIView.animate(withDuration: 0.3) {
                self.updateViewFrame(stickyOffsetY)
            }
        }
    }
    
    func updateViewFrame(_ offset: CGFloat) {
        guard let controller = controller else { return }
        controller.view.transform = .identity
        var originFrame = controller.view.frame
        originFrame.origin.y = offset
        originFrame.size.height = kScreenHeight - offset
        controller.view.frame = originFrame
        controller.view.layoutIfNeeded()
    }
    
    func getNearestOffset() -> CGFloat{
        
        guard stickyPoints.count > 0 else {
            return offsetY <= 0 ? 0 : UIScreen.main.bounds.height
        }
        stickyPoints.sort()
        let newOffsetY = offsetY + originY
        let newArr = stickyPoints.map { (item) -> CGFloat in
            let value = abs(item - newOffsetY)
            return value
        }
        let minValue = newArr.min() ?? newArr.first!
        let index = newArr.firstIndex(of: minValue) ?? 0
        let stickyOffsetY = stickyPoints[index]
        return stickyOffsetY
    }
}

