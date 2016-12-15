//
//  HistoryViewController.swift
//  FourSquare
//
//  Created by Duy Linh on 12/14/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

class HistoryViewController: ViewController {

    // MARK: - Cycle Life
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Private Function
    func configureNavigationBar() {
        navigationItem.title = Strings.MainMenuHistoryTitle
        navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName : UIColor.white]
        navigationController?.navigationBar.barTintColor =
            UIColor(red: 0, green: 153/255, blue: 255/255, alpha: 1)
    }

    override func configureUI() {
        super.configureUI()
        configureNavigationBar()
    }
}
