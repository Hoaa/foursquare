//
//  SearchViewController.swift
//  FourSquare
//
//  Created by Duy Linh on 12/14/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    
    // MARK: - Property
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    fileprivate let sectionInsets = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
    fileprivate let imagesSearch = ["Breakfast", "Lunch", "Dinner", "Coffee & Tea", "Nightlife", "Things To Do"]
    
    // MARK: - Cycle Life
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Private Function
    private func configureUI() {
        collectionView.registerNib(aClass: SearchCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesSearch.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(aClass: SearchCollectionViewCell.self, forIndexPath: indexPath)
        cell.imageSearch.image = UIImage(named: imagesSearch[indexPath.row])
        cell.searchKey.text = imagesSearch[indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 3
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = self.collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let availableHeight = self.collectionView.frame.height - 1
        let heightPerItem = availableHeight / 2
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let homeSearchViewController = HomeSearchViewController.vc()
        navigationController?.pushViewController(homeSearchViewController, animated: true)
    }
}
