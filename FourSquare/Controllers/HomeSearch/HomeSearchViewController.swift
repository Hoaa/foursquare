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
    var mapViewController: MapViewController?
    
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
    
    override func changeCollectionStyle() {
        super.changeCollectionStyle()
        if didShowMapView {
            self.mapViewController?.view.removeFromSuperview()
            self.mapViewController?.removeFromParentViewController()
            didShowMapView = false
        } else {
            distanceViewController.isChangeStyle()
            gridButton.animationDuration = animationDuration
            gridButton.isSelected = !gridButton.isSelected
        }
    }
    
    override func changeMapStyle() {
        super.changeMapStyle()
        if didShowMapView == false {
            self.mapViewController = MapViewController.vc()
            guard let pageMenuHeight = pageMenu?.menuHeight else {
                return
            }
            let mapViewFrame = CGRect(x: viewOfPageMenu.frame.origin.x, y: viewOfPageMenu.frame.origin.y + pageMenuHeight, width: viewOfPageMenu.frame.width, height: viewOfPageMenu.frame.height - pageMenuHeight)
            mapViewController?.view.frame = mapViewFrame
            if let mapViewController = self.mapViewController {
                self.addChildViewController(mapViewController)
                self.viewOfPageMenu.addSubview(mapViewController.view)
            }
            didShowMapView = true
        }
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
        pageMenu?.delegate = self
        if let pageMenu = self.pageMenu {
            self.viewOfPageMenu.addSubview(pageMenu.view)
        }
    }
}

extension HomeSearchViewController: CAPSPageMenuDelegate {
    func didMoveToPage(_ controller: UIViewController, index: Int) {
        print("chuyen tab")
    }
}
