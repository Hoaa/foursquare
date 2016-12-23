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
    
    // MARK: - Cycle Life
    override func viewDidLoad() {
        super.viewDidLoad()
        addVCToPageMenu()
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
    }
}
