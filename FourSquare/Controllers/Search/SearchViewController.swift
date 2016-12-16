//
//  SearchViewController.swift
//  FourSquare
//
//  Created by Duy Linh on 12/14/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

class SearchViewController: ViewController {
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    fileprivate let sectionInsets = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
    
    // MARK: - Cycle Life
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private Function
    override func configureUI() {
        super.configureUI()
        navigationController?.navigationBar.isHidden = true
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
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeue(aClass: SearchCollectionViewCell.self, forIndexPath: indexPath) else {return UICollectionViewCell()}
        cell.imageSearch.image = UIImage(named: "Search\(indexPath.row)")
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
