//
//  DetailSearchViewController.swift
//  FourSquare
//
//  Created by Duy Linh on 12/16/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

class DetailSearchViewController: ViewController {
    
    // MARK: - Property
    private lazy var searchBar = UISearchBar()
    private let menuStyleButtonFrame = CGRect(x: 0, y: 0, width: 25, height: 25)
    
    // MARK: - Cycle Life
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func configureUI() {
        super.configureUI()
        let manuStyleButton = UIButton(type: .custom)
        manuStyleButton.imageView?.contentMode = .scaleAspectFit
        manuStyleButton.setImage(#imageLiteral(resourceName: "StyleCollection"), for: UIControlState.normal)
        manuStyleButton.frame = menuButtonFrame
        manuStyleButton.addTarget(self, action: #selector(self.changeStyle), for: UIControlEvents.touchUpInside)
        let menuStyleBarButton = UIBarButtonItem(customView: manuStyleButton)
        navigationItem.rightBarButtonItem = menuStyleBarButton
        searchBar = UISearchBar()
        searchBar.placeholder = "Coffe & Tea"
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
    }
    
    // MARK: - Private Function
    @objc private func changeStyle() {
    }
}
