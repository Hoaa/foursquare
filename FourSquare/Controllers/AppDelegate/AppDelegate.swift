//
//  AppDelegate.swift
//  FourSquare
//
//  Created by Vo Duy Linh on 12/12/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
        // nmint8m: Add API key to project
        GMSServices.provideAPIKey("AIzaSyBNxeLGmIOaBci-ApSiZUltAOea9FmW7x8")
        GMSPlacesClient.provideAPIKey("AIzaSyBNxeLGmIOaBci-ApSiZUltAOea9FmW7x8")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        changeRootToTabBar()
        window?.makeKeyAndVisible()
        return true
    }
    func changeRootToTabBar() {
        let tabBarVC = TabBarViewController(nibName: "TabBarViewController", bundle: nil)
        window?.rootViewController = tabBarVC
    }
}
