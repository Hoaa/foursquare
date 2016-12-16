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
        self.setup()
        window = UIWindow(frame: UIScreen.main.bounds)
        self.changeRootToTabBar()
        window?.makeKeyAndVisible()
        return true
    }
    private func changeRootToTabBar() {
        let tabBarVC = TabBarViewController(nibName: "TabBarViewController", bundle: nil)
        window?.rootViewController = tabBarVC
    }
    
    func rootViewController() -> UIViewController {
        let searchViewController = SearchViewController.vc()
        let navigationController = UINavigationController(rootViewController: searchViewController)
        navigationController.navigationBar.isHidden = true
        return navigationController
    }
    
    private func setup() {
        setupGoogleMapAPIKey()
    }
    
    private func setupGoogleMapAPIKey() {
        GMSServices.provideAPIKey(GoogleMapsKeys.GMSServicesApiKey)
        GMSPlacesClient.provideAPIKey(GoogleMapsKeys.GMSPlacesClientApiKey)
    }
}
