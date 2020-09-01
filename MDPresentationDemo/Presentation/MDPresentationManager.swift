//
//  MDPresentationManager.swift
//  MDMotion
//
//  Created by  MarvinChan on 2019/7/11.
//  Copyright © 2019  MarvinChan. All rights reserved.
//

import UIKit

public enum MDPresentationDirection {
    case fade
    case left
    case top
    case right
    case bottom
    case center
    case custom(_ point: CGPoint)
}

public class MDPresentationConfig {
    /// 背景颜色
    var backgroundColor: UIColor = UIColor(white: 0, alpha: 0.5)
    /// 方向
    var direction: MDPresentationDirection = .fade
    /// 动画执行时间
    var animationDuration: TimeInterval = 0.3
    /// 显示内容的大小
    var contentSize: CGSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    /// 点击关闭
    var clickCloseEnabled: Bool = true
}
public final class MDPresentationManager: NSObject {
    // MARK: - Properties
    var config: MDPresentationConfig = MDPresentationConfig()
    var interactionTransition: MDPercentDrivenInteractiveTransition?
}

// MARK: - UIViewControllerTransitioningDelegate
extension MDPresentationManager: UIViewControllerTransitioningDelegate {
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentationController = MDPresentationController(presentedViewController: presented, presenting: presenting, config: config)
        presentationController.delegate = self
        return presentationController
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MDPresentationAnimator(config: config, isPresentation: true)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MDPresentationAnimator(config: config, isPresentation: false)
    }
    
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return (interactionTransition?.interacting ?? false) ? interactionTransition : nil
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return (interactionTransition?.interacting ?? false) ? interactionTransition : nil
    }
}

extension MDPresentationManager: UIAdaptivePresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        if traitCollection.verticalSizeClass == .compact {
            return .overFullScreen
        } else {
            return .none
        }
    }
}

