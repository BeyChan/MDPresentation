//
//  TestLeftViewController.swift
//  MDPresentationDemo
//
//  Created by MarvinChan on 2020/8/15.
//  Copyright © 2020 Melody Chan. All rights reserved.
//

import UIKit

class TestLeftViewController: BasePresentViewController {

    override var presentConfig: MDPresentationConfig {
        let config = MDPresentationConfig()
        config.direction = .left
        config.contentSize = CGSize(width: 300, height: kScreenHeight)
        return config
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
class TestRightViewController: BasePresentViewController {

    override var presentConfig: MDPresentationConfig {
        let config = MDPresentationConfig()
        config.direction = .right
        config.contentSize = CGSize(width: 300, height: kScreenHeight)
        return config
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
class TestCenterViewController: BasePresentViewController {

    override var presentConfig: MDPresentationConfig {
        let config = MDPresentationConfig()
        config.direction = .center
        config.contentSize = CGSize(width: 380, height: 400)
        return config
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
class TestTopViewController: BasePresentViewController {

    override var presentConfig: MDPresentationConfig {
        let config = MDPresentationConfig()
        config.direction = .top
        config.contentSize = CGSize(width: kScreenWidth, height: 400)
        return config
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
class TestBottomViewController: BasePresentViewController {

    override var presentConfig: MDPresentationConfig {
        let config = MDPresentationConfig()
        config.direction = .bottom
        config.contentSize = CGSize(width: kScreenWidth, height: 400)
        return config
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
class TestCustomViewController: UIViewController {

    var point: CGPoint = .zero
    var contentSize: CGSize = .zero
    
    private lazy var presentDelegate = MDPresentationManager()
    
    var presentConfig: MDPresentationConfig {
        let config = MDPresentationConfig()
        config.direction = .custom(point)
        config.contentSize = contentSize
        return config
    }
    
    public func setup() {
        presentDelegate.config = presentConfig
        self.transitioningDelegate = presentDelegate
        self.modalPresentationStyle = .custom
    }
    
    public init(start point: CGPoint,contentSize: CGSize) {
        super.init(nibName: nil, bundle: nil)
        self.point = point
        self.contentSize = contentSize
        setup()
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.roundCorners([.topLeft,.bottomLeft,.bottomRight], radius: 16)
    }
    
}

class TestNormalViewController: UIViewController,UIGestureRecognizerDelegate {
    
    var point: CGPoint = .zero
    var contentSize: CGSize = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(white: 0.1, alpha: 0.4)
        makeUI()
    }
    
    /// 初始化方法
    /// - Parameters:
    ///   - point: 起始点
    ///   - contentSize: 显示大小
    public init(start point: CGPoint,contentSize: CGSize) {
        super.init(nibName: nil, bundle: nil)
        self.point = point
        self.contentSize = contentSize
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func makeUI() {
        contentView.frame = CGRect.init(origin: point, size: contentSize)
        view.addSubview(contentView)
        view.addGestureRecognizer(tap)
    }
    
    
    
    @objc private func tapAction(tap: UITapGestureRecognizer) {
        if let _ = self.presentingViewController {
            dismiss(animated: false, completion: nil)
        }
    }
    
    private lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(tap:)))
        tap.delegate = self
        return tap
    }()
    
    lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.roundCorners([.topLeft,.bottomLeft,.bottomRight], radius: 16)
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return !contentView.frame.contains(gestureRecognizer.location(in: view))
    }
}

extension UIViewController {
    public func showPopover(controller: UIViewController) {
        controller.modalPresentationStyle = .overFullScreen
        let transition = CATransition()
        transition.type = .fade
        transition.duration = 0.25
        UIApplication.shared.keyWindow?.layer.add(transition, forKey: "GWPopoverAnimationKey")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            UIApplication.shared.keyWindow?.layer.removeAnimation(forKey: "GWPopoverAnimationKey")
        }
        present(controller, animated: false, completion: nil)
    }
}
