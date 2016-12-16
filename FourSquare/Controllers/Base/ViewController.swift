//
//  ViewController.swift
//  FourSquare
//
//  Created by Duy Linh on 12/15/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadData()
    }
    
    func loadData() {
    }
    
    func configureUI() {
        navigationController?.navigationBar.barTintColor = Color.Blue153
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func showLoad() {
    }
    
    func hideLoading() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
