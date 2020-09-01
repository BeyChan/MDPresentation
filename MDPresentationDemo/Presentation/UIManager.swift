//
//  UIManager.swift
//  MDPresentationDemo
//
//  Created by MarvinChan on 2020/8/17.
//  Copyright © 2020 Melody Chan. All rights reserved.
//

import UIKit

let kScreenHeight = UIScreen.main.bounds.height
let kScreenWidth = UIScreen.main.bounds.width
let kNavigationBarHeight = MDUI.navigationBarH
let kTabBarHeight = MDUI.tabBarH
let kSafeTop = MDUI.safeAreaTop()
let kSafeBottom = MDUI.safeAreaBottom()

struct MDUI {
    static var window:UIWindow? {
        return UIApplication.shared.delegate?.window ?? UIApplication.shared.keyWindow ?? nil
    }
    
    static var screenSize:CGSize {
        return UIScreen.main.bounds.size
    }
    
    static var navigationBarH:CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.statusBarFrame.size.height + (MDUI.visibleVC?.navigationController?.navigationBar.frame.size.height ?? 44)
        } else {
            return 20.0 + (MDUI.visibleVC?.navigationController?.navigationBar.frame.size.height ?? 44)
        }
    }
    
    static var tabBarH:CGFloat {
        return MDUI.visibleVC?.tabBarController?.tabBar.frame.size.height ?? 59
    }
    
    static var hasSafeArea: Bool {
        guard #available(iOS 11.0, *)   else { return false }
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }

    static func safeAreaTop() -> CGFloat {
        if #available(iOS 11.0, *) {
            //iOS 12.0以后的非刘海手机top为 20.0
            guard let window = UIApplication.shared.delegate?.window else {
                return 20
            }
            if window?.safeAreaInsets.bottom == 0 {
                return 20.0
            }
            return window?.safeAreaInsets.top ?? 20.0
        }
        return 20.0
    }
    
    static func safeAreaBottom() -> CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0
        }
        return 0
    }
    
    
    static var visibleVC:UIViewController? {
        func visibleVC(_ vc: UIViewController? = nil) -> UIViewController? {
            if let nv = vc as? UINavigationController
            {
                return visibleVC(nv.visibleViewController)
            } else if let tb = vc as? UITabBarController,
                let select = tb.selectedViewController
            {
                return visibleVC(select)
            } else if let presented = vc?.presentedViewController {
                return visibleVC(presented)
            }
            return vc
        }
        let vc = MDUI.window?.rootViewController
        return visibleVC(vc)
    }
    
    static func iOSAdjustmentBehavior() {
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
            UICollectionView.appearance().contentInsetAdjustmentBehavior = .never
            /// 高度自适应会失效，需要高度自适应的tableView 需重新设置
            UITableView.appearance().contentInsetAdjustmentBehavior = .never
            UITableView.appearance().estimatedRowHeight = 0
            UITableView.appearance().estimatedSectionHeaderHeight = 0
            UITableView.appearance().estimatedSectionFooterHeight = 0
        } else {
            UITableView.appearance().estimatedRowHeight = 100
        }
    }
}
