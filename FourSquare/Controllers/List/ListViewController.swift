//
//  ListViewController.swift
//  FourSquare
//
//  Created by Duy Linh on 12/26/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

class ListViewController: BaseViewController {
    
    // MARK: - Cycle Life
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
    }
    
    // MARK: - Private Function
    private func configureNavigationBar() {
        navigationItem.title = Strings.MainMenuListTitle
        navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName : UIColor.white]
    }
}
