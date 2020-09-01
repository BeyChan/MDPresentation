//
//  BaseViewController.swift
//  MDPresentationDemo
//
//  Created by MarvinChan on 2020/8/15.
//  Copyright © 2020 Melody Chan. All rights reserved.
//

import UIKit

class BasePresentViewController: UIViewController {
    
    private lazy var presentDelegate = MDPresentationManager()
    
    var presentConfig: MDPresentationConfig {
        let config = MDPresentationConfig()
        return config
    }
    
    public func setup() {
        presentDelegate.config = presentConfig
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        self.navigationItem.leftBarButtonItem = closeBarButton
        
    }
    
    lazy var closeBarButton: UIBarButtonItem = {
        let view = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(closeAction(sender:)))
        return view
    }()
    
    @objc func closeAction(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
