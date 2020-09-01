//
//  MDPresentationController.swift
//  MDMotion
//
//  Created by  MarvinChan on 2019/7/11.
//  Copyright © 2019  MarvinChan. All rights reserved.
//

import UIKit

class MDPresentationController: UIPresentationController {
    
    // MARK: - Properties
    // 显示的区域大小
    private var contentSize: CGSize
    private var direction: MDPresentationDirection
    private var clickCloseEnabled: Bool
    private var backgroundColor: UIColor
    fileprivate var dimmingView: UIView!
    
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = .zero
        guard let containerView = containerView  else { return .zero }
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView.bounds.size)
        switch direction {
        case .fade:
            frame.origin.x = containerView.frame.width/2-contentSize.width/2
            frame.origin.y = containerView.frame.height/2-contentSize.height/2
        case .left:
            frame.origin.y = containerView.frame.height/2-contentSize.height/2
        case .right:
            frame.origin.x = containerView.frame.width - contentSize.width
            frame.origin.y = containerView.frame.height/2-contentSize.height/2
        case .top:
            frame.origin.x = containerView.frame.width/2-contentSize.width/2
        case .bottom:
            frame.origin.y = containerView.frame.height - contentSize.height
            frame.origin.x = containerView.frame.width/2-contentSize.width/2
        case .center:
            frame.origin.x = containerView.frame.width/2-contentSize.width/2
            frame.origin.y = containerView.frame.height/2-contentSize.height/2
        case .custom(let point):
            var originX = point.x
            var originY = point.y
            if originX + contentSize.width > containerView.frame.width {
                originX = originX - contentSize.width
            }
            if originY + contentSize.height > containerView.frame.height {
                originY = originY - contentSize.height
            }
            frame.origin.x = originX
            frame.origin.y = originY
        }
        return frame
    }
    
    // MARK: - Initializers
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, config: MDPresentationConfig) {
        self.direction = config.direction
        self.contentSize = config.contentSize
        self.clickCloseEnabled = config.clickCloseEnabled
        self.backgroundColor = config.backgroundColor
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        setupDimmingView()
    }
    
    override func presentationTransitionWillBegin() {
        containerView?.insertSubview(dimmingView, at: 0)
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|", options: [], metrics: nil, views: ["dimmingView": dimmingView!]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|", options: [], metrics: nil, views: ["dimmingView": dimmingView!]))
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return contentSize
    }
    
    /// 统一设置圆角
//    override var presentedView: UIView? {
//        if let v = self.presentedViewController.view{
//            v.layer.cornerRadius = 20.0
//            return v
//        }
//        return UIView()
//    }
    
}

// MARK: - Private
private extension MDPresentationController {
    
    func setupDimmingView() {
        dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = backgroundColor
        dimmingView.alpha = 0.0
        if clickCloseEnabled {
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
            dimmingView.addGestureRecognizer(recognizer)
        }
    }
    
    @objc dynamic func handleTap(recognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
}
extension UIView {
    func blurEffect(_ color:UIColor = UIColor.clear,  style:UIBlurEffect.Style = .light, block:((UIVisualEffectView) -> Void)? = nil) {
        self.layoutIfNeeded()
        self.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.backgroundColor = color
        blurEffectView.frame = self.bounds
        self.addSubview(blurEffectView)
        self.sendSubviewToBack(blurEffectView)
        block?(blurEffectView)
    }
}
