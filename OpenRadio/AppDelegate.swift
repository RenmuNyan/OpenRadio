//
//  AppDelegate.swift
//  OpenRadio
//
//  Created by DreamLover on 2016/01/26.
//  Copyright © 2016年 Renmu. All rights reserved.
//

import UIKit
import KGFloatingDrawer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        self.window?.rootViewController = drawerViewController
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - 抽屉菜单配置(FloatingSetting)
    private var _drawerViewController: KGDrawerViewController?
    var drawerViewController: KGDrawerViewController {
        get {
            if let viewController = _drawerViewController {
                return viewController
            }
            return prepareDrawerViewController()
        }
    }
    
    func prepareDrawerViewController() -> KGDrawerViewController {
        
        let drawerViewController = KGDrawerViewController()
        
        let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
        let playList = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("RightViewController") as! RightViewController
        
        playList.delegate = mainView
        
        drawerViewController.centerViewController = mainView
        drawerViewController.rightViewController  = playList
        
        _drawerViewController = drawerViewController
        
     
        return drawerViewController
    }
    
    func toggleRightDrawer(sender:AnyObject, animated:Bool) {
        _drawerViewController?.toggleDrawer(.Right, animated: true, complete: { (finished) -> Void in
            // none...
        })
    }
    

}

