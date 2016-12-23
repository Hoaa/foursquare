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
        let searchVC = SearchViewController(nibName: "SearchViewController", bundle: nil)
        let naviSearchVC = UINavigationController(rootViewController: searchVC)
        naviSearchVC.navigationBar.isTranslucent = false
        let listsVC = ListsViewController(nibName: "ListsViewController", bundle: nil)
        let naviListsVC = UINavigationController(rootViewController: listsVC)
        naviListsVC.navigationBar.isTranslucent = false
        let historyVC = HistoryViewController(nibName: "HistoryViewController", bundle: nil)
        let naviHistoryVC = UINavigationController(rootViewController: historyVC)
        naviHistoryVC.navigationBar.isTranslucent = false
        let profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        let naviProfileVC = UINavigationController(rootViewController: profileVC)
        naviProfileVC.navigationBar.isTranslucent = false
        self.viewControllers = [naviSearchVC,
                                naviListsVC,
                                naviHistoryVC,
                                naviProfileVC]
        let itemLists = UITabBarItem(title: "List", image: #imageLiteral(resourceName: "Lists"), tag: 4)
        let itemSearch = UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "Search"), tag: 1)
        let itemHistory = UITabBarItem(title: "History", image: #imageLiteral(resourceName: "History"), tag: 2)
        let itemProfile = UITabBarItem(title: "Me", image: #imageLiteral(resourceName: "Profile"), tag: 3)
        listsVC.tabBarItem = itemLists
        searchVC.tabBarItem = itemSearch
        historyVC.tabBarItem = itemHistory
        profileVC.tabBarItem = itemProfile
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor(red: 0, green: 153/255, blue: 255/255, alpha: 1)
    }
}
