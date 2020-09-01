//
//  NavigationViewController.swift
//  MDPresentationDemo
//
//  Created by MarvinChan on 2020/8/15.
//  Copyright © 2020 Melody Chan. All rights reserved.
//

import UIKit

class FadeNavigationController: UINavigationController {
    
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
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
