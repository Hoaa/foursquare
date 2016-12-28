//
//  HistoryViewController.swift
//  FourSquare
//
//  Created by Duy Linh on 12/14/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

class HistoryViewController: BaseViewController {

    // MARK: - Cycle Life
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
    }
    
    // MARK: - Private Function
    private func configureNavigationBar() {
        navigationItem.title = Strings.MainMenuHistoryTitle
        navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName : UIColor.white]
    }
}
