//
//  ViewController.swift
//  MDPresentationDemo
//
//  Created by MarvinChan on 2020/8/15.
//  Copyright © 2020 Melody Chan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private lazy var presentDelegate = MDPresentationManager()

    @IBAction func custom(_ sender: Any) {
        let button = sender as! UIButton
        
        let controlller = TestCustomViewController(start: button.frame.origin,
                                                   contentSize: CGSize(width: 200, height: 150))
        self.showDetailViewController(controlller, sender: nil)
    }
    @IBAction func custom2(_ sender: Any) {
        let ctrl = BasePresentViewController()
        let nav = FadeNavigationController(rootViewController: ctrl)
        self.showDetailViewController(nav, sender: nil)
    }
    
    @IBAction func custom3(_ sender: Any) {
        let button = sender as! UIButton
        
        let ctrl = TestNormalViewController(start: button.frame.origin,
                                            contentSize: CGSize(width: 200, height: 150))
        self.showPopover(controller: ctrl)
    }
    
    @IBAction func top(_ sender: Any) {
        let controlller = TestTopViewController()
        self.showDetailViewController(controlller, sender: nil)
    }
    
    @IBAction func left(_ sender: Any) {
        let controlller = TestLeftViewController()
        self.showDetailViewController(controlller, sender: nil)
    }
    
    @IBAction func center(_ sender: Any) {
        let controlller = TestCenterViewController()
        self.showDetailViewController(controlller, sender: nil)
    }
    
    @IBAction func down(_ sender: Any) {
        let controlller = TestBottomViewController()
        self.showDetailViewController(controlller, sender: nil)
    }
    
    @IBAction func right(_ sender: Any) {
        let controlller = TestRightViewController()
        self.showDetailViewController(controlller, sender: nil)
    }
    
    @IBAction func gaode(_ sender: Any) {
        let controller = TestViewController()
        self.show(controller, sender: nil)
    }
    @IBAction func gaode2(_ sender: Any) {
//        let controller = TestScollViewController()
//        self.showDetailViewController(controller, sender: nil)
        
        let ctrl = GWMapViewController()
        self.show(ctrl, sender: nil)
    }
}

