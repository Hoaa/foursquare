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
    var itemViewControllers : [MenuItemViewController] = []
    var parameters: [CAPSPageMenuOption] = [
        .menuHeight(35.0),
        .menuItemWidth(UIScreen.main.bounds.width / 4),
        .menuMargin(0),
        .scrollMenuBackgroundColor(Color.Blue145),
        .selectionIndicatorColor(Color.White255),
        .selectedMenuItemLabelColor(Color.White255),
        .unselectedMenuItemLabelColor(Color.White216)
    ]
    var distanceViewController: DistanceViewController = DistanceViewController.vc()
    var priceViewController: PriceViewController = PriceViewController.vc()
    var openNowViewController: OpenNowViewController = OpenNowViewController.vc()
    var ratingViewController: RatingViewController = RatingViewController.vc()
    
    // MARK: - Cycle Life
    override func viewDidLoad() {
        super.viewDidLoad()
        itemViewControllers = setDefaultMenuItems()
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
    private func setDefaultMenuItems() -> [MenuItemViewController] {
        var viewControllers: [MenuItemViewController] = []
        
        distanceViewController.title = Strings.MenuItemDistance
        viewControllers.append(distanceViewController)
        
        priceViewController.title = Strings.MenuItemPrice
        viewControllers.append(priceViewController)
        
        openNowViewController.title = Strings.MenuItemOpenNow
        viewControllers.append(openNowViewController)
        
        ratingViewController.title = Strings.MenuItemRating
        viewControllers.append(ratingViewController)
        return viewControllers
    }
    
    private func configureMenuPage() {
        setUpMenuPage()
    }
    
    private func setUpMenuPage() {
        pageMenu = CAPSPageMenu(viewControllers: itemViewControllers, frame: viewOfPageMenu.frame, pageMenuOptions: parameters)
        if let pageMenu = self.pageMenu {
            self.viewOfPageMenu.addSubview(pageMenu.view)
        }
    }
}
