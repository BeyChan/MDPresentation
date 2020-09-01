//
//  MDPresentationAnimator.swift
//  MDMotion
//
//  Created by  MarvinChan on 2019/7/11.
//  Copyright © 2019  MarvinChan. All rights reserved.
//

import UIKit

public class MDPresentationAnimator: NSObject {
    // MARK: - Properties
    
    let config: MDPresentationConfig
    let isPresentation: Bool
    
    // MARK: - Initializers
    init(config: MDPresentationConfig, isPresentation: Bool) {
        self.config = config
        self.isPresentation = isPresentation
        super.init()
    }
}

extension MDPresentationAnimator:  UIViewControllerAnimatedTransitioning{
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return config.animationDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key = isPresentation ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
        let controller = transitionContext.viewController(forKey: key)!
        let direction = config.direction
        if isPresentation {
            transitionContext.containerView.addSubview(controller.view)
        }
        
        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        var isFade = false
        switch direction {
        case .fade:
            isFade = true
            controller.view.alpha = isPresentation ? 0 : 1
        case .left:
            dismissedFrame.origin.x = -presentedFrame.width
        case .right:
            dismissedFrame.origin.x = transitionContext.containerView.frame.size.width
        case .top:
            dismissedFrame.origin.y = -presentedFrame.height
        case .bottom:
            dismissedFrame.origin.y = transitionContext.containerView.frame.size.height
        case .center:
//            let containerViewHeight = transitionContext.containerView.frame.size.height
//            dismissedFrame.origin.y = isPresentation ? -containerViewHeight: containerViewHeight
            dismissedFrame.origin = controller.view.center
            dismissedFrame.size = .zero
        case .custom(let point):
            dismissedFrame.origin = point
            dismissedFrame.size = .zero
            
        }
        
            
        let initialFrame = isPresentation ? dismissedFrame : presentedFrame
        let finalFrame = isPresentation ? presentedFrame : dismissedFrame
        
        let animationDuration = transitionDuration(using: transitionContext)
        controller.view.frame = initialFrame
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.6,
                       options: .curveEaseInOut,
                       animations: {
                        controller.view.frame = finalFrame
                        if isFade {
                            controller.view.alpha = 1 - controller.view.alpha
                        }
        }) { (finished) in
            transitionContext.completeTransition(finished)
        }
    }
}
