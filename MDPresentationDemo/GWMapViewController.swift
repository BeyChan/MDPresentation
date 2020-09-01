//
//  GWMapViewController.swift
//  MDPresentationDemo
//
//  Created by MarvinChan on 2020/8/17.
//  Copyright © 2020 Melody Chan. All rights reserved.
//

import UIKit
import MapKit
class GWMapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let mapView = MKMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        view.addSubview(mapView)
        
        addSearchViewCtrl()
    }
    
    func addSearchViewCtrl() {
        searchCtrl.view.frame = searchCtrl.displayFrame
        addChild(searchCtrl)
        view.addSubview(searchCtrl.view)
        self.view.layoutIfNeeded()
        searchCtrl.didMove(toParent: self)
    }
    
    lazy var searchCtrl: GWSearchTableViewController = {
        let ctrl = GWSearchTableViewController()
        return ctrl
    }()

}
