//
//  YourPlacesView.swift
//  FourSquare
//
//  Created by nmint8m on 16.12.16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

protocol YourPlacesViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

protocol YourPlacesViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

class YourPlacesView: UIView {

    var datasource: YourPlacesViewDataSource?
    var delegate: YourPlacesViewDelegate?
    
    @IBOutlet weak var yourPlacesCollectionView: UICollectionView!
    
    func configursView() {
        // Frame
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: (self.bounds.width - 15) / 2, height: self.bounds.height - 10)
        yourPlacesCollectionView.collectionViewLayout = layout
        
        // Register
        let nibForFeature = UINib(nibName: "ListsItemCollectionViewCell", bundle: nil)
        yourPlacesCollectionView.register(nibForFeature, forCellWithReuseIdentifier: "ListsItemCollectionViewCell")
        
        // DataSource, Delegate
        yourPlacesCollectionView.dataSource = self
        yourPlacesCollectionView.delegate = self
    }

}

extension YourPlacesView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let numberOfSections = datasource?.numberOfSections(in: collectionView) {
            return numberOfSections
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let numberOfItemsInSection = datasource?.collectionView(collectionView, numberOfItemsInSection: section){
            return numberOfItemsInSection
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = datasource?.collectionView(collectionView, cellForItemAt: indexPath) {
            return cell
        }
        return UICollectionViewCell()
    }
}

extension YourPlacesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionView(collectionView, didSelectItemAt: indexPath)
    }
}
