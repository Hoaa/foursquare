//
//  TabBarViewController.swift
//  FourSquare
//
//  Created by Duy Linh on 12/14/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    // MARK: - Cycle Life
    override func viewDidLoad() {
        super.viewDidLoad()
        configItemViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Private Functions
    private func configItemViewController() {
        let listVC = ListViewController()
        let naviListVC = UINavigationController(rootViewController: listVC)
        naviListVC.navigationBar.isTranslucent = false
        let searchVC = SearchViewController()
        let naviSearchVC = UINavigationController(rootViewController: searchVC)
        naviSearchVC.navigationBar.isTranslucent = false
        let historyVC = HistoryViewController()//override init
        let naviHistoryVC = UINavigationController(rootViewController: historyVC)
        naviHistoryVC.navigationBar.isTranslucent = false
        let profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        let naviProfileVC = UINavigationController(rootViewController: profileVC)
        naviProfileVC.navigationBar.isTranslucent = false
        self.viewControllers = [naviSearchVC,
                                naviListVC,
                                naviHistoryVC,
                                naviProfileVC]
        let itemList = UITabBarItem(title: "List", image: #imageLiteral(resourceName: "Lists"), tag: 0)
        let itemSearch = UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "Search"), tag: 1)
        let itemHistory = UITabBarItem(title: "History", image: #imageLiteral(resourceName: "History"), tag: 2)
        let itemProfile = UITabBarItem(title: "Me", image: #imageLiteral(resourceName: "Profile"), tag: 3)
        listVC.tabBarItem = itemList
        searchVC.tabBarItem = itemSearch
        historyVC.tabBarItem = itemHistory
        profileVC.tabBarItem = itemProfile
        tabBar.isTranslucent = false
        tabBar.tintColor = Color.Blue255
    }
}
