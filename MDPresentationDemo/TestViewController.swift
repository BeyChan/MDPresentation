//
//  TestViewController.swift
//  MDPresentationDemo
//
//  Created by MarvinChan on 2020/8/15.
//  Copyright © 2020 Melody Chan. All rights reserved.
//

import UIKit
import MapKit

class TestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapV = MKMapView(frame: view.bounds)
        view.addSubview(mapV)
        
        addTestController()
        
        if let _ = presentingViewController {
            self.navigationItem.leftBarButtonItem = closeBarButton
        }
    }
    
    func addTestController() {
        addChild(testCtrl)
        view.addSubview(testCtrl.view)
        self.view.layoutIfNeeded()
        testCtrl.didMove(toParent: self)
    }
    
    lazy var closeBarButton: UIBarButtonItem = {
        let view = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(closeAction(sender:)))
        return view
    }()
    
    @objc func closeAction(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    lazy var testCtrl: TestScollViewController = {
        let test = TestScollViewController()
        test.view.frame = test.displayFrame
        return test
    }()
    
}

