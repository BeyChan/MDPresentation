//
//  AppDelegate.swift
//  MDPresentationDemo
//
//  Created by MarvinChan on 2020/8/15.
//  Copyright © 2020 Melody Chan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let ctrl = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        self.window?.rootViewController = ctrl
        self.window?.makeKeyAndVisible()
        return true
    }


}

