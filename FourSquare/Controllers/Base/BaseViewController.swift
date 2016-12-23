//
//  BaseViewController.swift
//  FourSquare
//
//  Created by Duy Linh on 12/23/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit
class BaseViewController: ViewController {

    // MARK: - Property
    private lazy var searchBar = UISearchBar()
    private let menuStyleButtonFrame = CGRect(x: 0, y: 0, width: 25, height: 25)
    private var gridButoon = SwitchLayoutButton()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    // MARK: - Public function
    func setupNavigationBar() {
        configUINavigationBar()
        setupNavigationItem()
    }
    
    func setupNavigationItem() {
        if let rootNavigationController  = navigationController?.viewControllers.first {
            if rootNavigationController == self {
            } else {
                addSearchBar()
                addRightBarButton()
            }
        }
    }
    
    func showAndHideMapViewAction(sender: AnyObject) {
        
    }
    
    // MARK: - Private function
    private func configUINavigationBar() {
        navigationController?.navigationBar.barTintColor = Color.Blue153
        navigationController?.navigationBar.tintColor = Color.White
    }
    
    private func addSearchBar() {
        searchBar = UISearchBar()
        searchBar.placeholder = "Venue name..."
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
    }
    
    private func addRightBarButton() {
        let mapButton = UIButton(type: UIButtonType.custom)
        mapButton.imageView?.contentMode = .scaleAspectFit
        mapButton.setImage(#imageLiteral(resourceName: "StyleMap"), for: UIControlState.normal)
        mapButton.frame = menuButtonFrame
        mapButton.addTarget(self, action: #selector(showAndHideMapViewAction), for: UIControlEvents.touchUpInside)
        let mapBarButton = UIBarButtonItem(customView: mapButton)
        gridButoon.isSelected = true
        gridButoon.frame = menuStyleButtonFrame
        gridButoon.awakeFromNib()
        gridButoon.isSelected = true
        gridButoon.addTarget(self, action: #selector(changeStyle), for: UIControlEvents.touchUpInside)
        let gridBarButton = UIBarButtonItem(customView: gridButoon)
        navigationItem.rightBarButtonItems = [gridBarButton, mapBarButton]
    }
    
    @objc private func changeStyle() {
        gridButoon.isSelected = !gridButoon.isSelected
    }
    
}
