//
//  DetailSearchViewController.swift
//  FourSquare
//
//  Created by Duy Linh on 12/16/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit
import PageMenu

enum DefaultMenuItem: Int {
    case Price
    case OpenNow
    case Rating
    case Saved
    case Liked

    var title: String {
        switch self {
        case .Price:
            return Strings.MenuItemPrice
        case .OpenNow:
            return Strings.MenuItemOpenNow
        case .Rating:
            return Strings.MenuItemRating
        case .Saved:
            return Strings.MenuItemSaved
        case .Liked:
            return Strings.MenuItemLiked
        }
    }
}

class DetailSearchViewController: BaseViewController {
    
    // MARK: - Property
    @IBOutlet private weak var viewOfPageMenu: UIView!
    var pageMenu : CAPSPageMenu?
    var controllerArray : [ViewController] = []
    var listViewController : ListViewController = ListViewController.vc()
    var historyViewController: HistoryViewController = HistoryViewController.vc()
    var parameters: [CAPSPageMenuOption] = [
        .menuItemSeparatorWidth(4.3),
        .useMenuLikeSegmentedControl(true),
        .menuItemSeparatorPercentageHeight(0.1)
    ]
    
    // MARK: - Cycle Life
    override func viewDidLoad() {
        super.viewDidLoad()
        addVCToPageMenu()
        pageMenu!.viewBackgroundColor = Color.Blue153
        pageMenu!.menuShadowColor = Color.Blue153
        pageMenu!.menuItemSeparatorColor = Color.Blue153
        pageMenu!.bottomMenuHairlineColor = Color.Blue153
        pageMenu!.scrollMenuBackgroundColor = Color.Blue153
        pageMenu!.selectionIndicatorColor = Color.Blue153
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Private Function
    private func addVCToPageMenu() {
        listViewController.title = "Lists"
        controllerArray.append(listViewController)
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        self.view.addSubview(pageMenu!.view)
        
        historyViewController.title = "History"
        controllerArray.append(historyViewController)
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        self.view.addSubview(pageMenu!.view)
    }
}
