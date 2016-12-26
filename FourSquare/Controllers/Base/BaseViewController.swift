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
    var gridButton = SwitchLayoutButton()
    var didShowMapView: Bool = false

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
    
    func changeMapStyle() {
    }
    
    func changeCollectionStyle() {
    }
    
    // MARK: - Private function
    private func configUINavigationBar() {
        navigationController?.navigationBar.barTintColor = Color.Blue255
        navigationController?.navigationBar.tintColor = Color.White255
    }
    
    private func addSearchBar() {
        searchBar = UISearchBar()
        searchBar.placeholder = "Venue name..."
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
    
    private func addRightBarButton() {
        //mapButton
        let mapButton = UIButton(type: UIButtonType.custom)
        mapButton.imageView?.contentMode = .scaleAspectFit
        mapButton.setImage(#imageLiteral(resourceName: "StyleMap"), for: UIControlState.normal)
        mapButton.frame = menuStyleButtonFrame
        mapButton.addTarget(self, action: #selector(changeMapStyle), for: UIControlEvents.touchUpInside)
        let mapBarButton = UIBarButtonItem(customView: mapButton)
        //gridButoon
        gridButton.frame = menuStyleButtonFrame
        gridButton.awakeFromNib()
        gridButton.isSelected = true
        gridButton.addTarget(self, action: #selector(changeCollectionStyle), for: UIControlEvents.touchUpInside)
        let gridBarButton = UIBarButtonItem(customView: gridButton)
        navigationItem.rightBarButtonItems = [gridBarButton, mapBarButton]
    }
}

extension BaseViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
