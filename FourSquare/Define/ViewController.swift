//
//  ViewController.swift
//  FourSquare
//
//  Created by Duy Linh on 12/15/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Public Function
    func SetupNavigationBar() {
        navigationItem.title = Strings.MainMenuHistoryTitle
        navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName : UIColor.white]
    }
}
