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
    case Distance
    case Price
    case OpenNow
    case Rating

    var title: String {
        switch self {
        case .Distance:
            return Strings.MenuItemDistance
        case .Price:
            return Strings.MenuItemPrice
        case .OpenNow:
            return Strings.MenuItemOpenNow
        case .Rating:
            return Strings.MenuItemRating
        }
    }
}

class HomeSearchViewController: BaseViewController {
    
    // MARK: - Property
    @IBOutlet private weak var viewOfPageMenu: UIView!
    var pageMenu : CAPSPageMenu?
    var controllerArray : [MenuItemViewController] = []
    var parameters: [CAPSPageMenuOption] = [
        .menuItemSeparatorWidth(4.3),
        .useMenuLikeSegmentedControl(true),
        .menuItemSeparatorPercentageHeight(0.1)
    ]
    var distanceViewController: DistanceViewController = DistanceViewController.vc()
    
    // MARK: - Cycle Life
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMenuPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func changeStyle(sender: AnyObject) {
        super.changeStyle(sender: sender)
        distanceViewController.isChangeStyle()
        gridButton.animationDuration = animationDuration
        gridButton.isSelected = !gridButton.isSelected
    }
    
    // MARK: - Private Function
    private func configureMenuPage() {
        setUpMenuPage()
    }
    
    private func setUpMenuPage() {
        distanceViewController.title = "Distance"
        controllerArray.append(distanceViewController)
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: viewOfPageMenu.frame, pageMenuOptions: parameters)
        self.viewOfPageMenu.addSubview(pageMenu!.view)
    }
}
