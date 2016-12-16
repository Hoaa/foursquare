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
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    private lazy var searchBar = UISearchBar()
    private let menuStyleButtonFrame = CGRect(x: 0, y: 0, width: 25, height: 25)
    fileprivate let sectionInsets = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
    
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
        self.configureNavigationItem()
        collectionView.registerNib(aClass: DefaultVenueCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - Private Function
    private func configureNavigationItem() {
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
    
    @objc private func changeStyle() {
    }
}

// MARK: - UICollectionViewDataSource
extension DetailSearchViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeue(aClass: DefaultVenueCollectionViewCell.self, forIndexPath: indexPath) else {return UICollectionViewCell()}
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 96)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
