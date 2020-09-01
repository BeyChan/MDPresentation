//
//  TestScollViewController.swift
//  XboxSchedule
//
//  Created by MarvinChan on 2020/8/14.
//

import UIKit
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

class TestScollViewController: UIViewController {

    private lazy var presentDelegate = MDPresentationManager()
    
    public func setup() {
        let config = MDPresentationConfig()
        config.direction = .bottom
        config.contentSize = CGSize(width: kScreenWidth, height: kScreenHeight-150)
        presentDelegate.config = config
        self.transitioningDelegate = presentDelegate
        self.modalPresentationStyle = .custom
    }
    
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        setup()
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    

    public var displayFrame: CGRect {
        return CGRect(x: 0, y: 400, width: kScreenWidth, height: kScreenHeight-400)
    }
        
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.roundCorners([.topLeft,.topRight], radius: 16)
        view.backgroundColor = UIColor.yellow
        
        view.addSubview(scrollView)
        setupInteractiveTransition()
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollV = UIScrollView(frame: CGRect(x: 0, y: 60, width: view.width, height: view.height-60))
        scrollV.backgroundColor = .lightGray
        scrollV.showsVerticalScrollIndicator = true
        scrollV.contentSize = CGSize(width: 0, height: kScreenHeight+500)
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 60, y: 80, width:120, height: 50)
        button.setTitle("push按钮", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(pushCtrl), for: .touchUpInside)
        scrollV.addSubview(button)
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 60, y: 160, width: 120, height: 50)
        btn.setTitle("present按钮", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.addTarget(self, action: #selector(presentCtrl), for: .touchUpInside)
        scrollV.addSubview(btn)
        return scrollV
    }()
    
    @objc func pushCtrl() {
        let ctrl = UIViewController()
        ctrl.view.backgroundColor = .yellow
        MDUI.visibleVC?.navigationController?.pushViewController(ctrl, animated: true)
    }

    @objc func presentCtrl() {
        let ctrl = TestViewController()
//        ctrl.modalPresentationStyle = .fullScreen
        let nav = FadeNavigationController(rootViewController: ctrl)
        MDUI.visibleVC?.showDetailViewController(nav, sender: nil)
    }
    
    fileprivate func setupInteractiveTransition() {
        let transition = MDPullDrivenInteractiveTransition(self, scrollView: self.scrollView)
        transition.stickyPoints = [100,400,kScreenHeight - 60]
        presentDelegate.interactionTransition = transition
    }
    

}


extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))

        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    /// SwifterSwift: Corner radius of view; also inspectable from Storyboard.
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }

    /// SwifterSwift: Size of view.
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }

    /// SwifterSwift: Width of view.
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
}
