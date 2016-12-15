//
//  SearchViewController.swift
//  FourSquare
//
//  Created by Duy Linh on 12/14/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Cycle Life
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Private Function
    private func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor =
            UIColor(red: 0, green: 153/255, blue: 255/255, alpha: 1)
    }

    private func configureUI() {
    }
}
