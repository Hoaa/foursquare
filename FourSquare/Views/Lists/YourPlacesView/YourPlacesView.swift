//
//  YourPlacesView.swift
//  FourSquare
//
//  Created by nmint8m on 16.12.16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

protocol YourPlacesViewDataSource {
    func numberOfSections(_ view: UIView, collectionView: UICollectionView) -> Int
    func collectionView(_ view: UIView, collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ view: UIView, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

protocol YourPlacesViewDelegate {
    func collectionView(_ view: UIView, collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

class YourPlacesView: UIView {

    var datasource: YourPlacesViewDataSource?
    var delegate: YourPlacesViewDelegate?
    
    @IBOutlet weak var yourPlacesCollectionView: UICollectionView!
    
    func configureView() {
        // Frame
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: (self.bounds.width - 30) / 2, height: self.bounds.height - 20)
        yourPlacesCollectionView.collectionViewLayout = layout
        
        // Register
        let nibForYourPlaces = UINib(nibName: "ListsItemCollectionViewCell", bundle: nil)
        yourPlacesCollectionView.register(nibForYourPlaces, forCellWithReuseIdentifier: "ListsItemCollectionViewCell")
        
        // DataSource, Delegate
        yourPlacesCollectionView.dataSource = self
        yourPlacesCollectionView.delegate = self
    }

}

extension YourPlacesView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let numberOfSections = datasource?.numberOfSections(self, collectionView: collectionView) {
            return numberOfSections
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let numberOfItemsInSection = datasource?.collectionView(self, collectionView: collectionView, numberOfItemsInSection: section){
            return numberOfItemsInSection
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = datasource?.collectionView(self, collectionView: collectionView, cellForItemAt: indexPath) {
            return cell
        }
        return UICollectionViewCell()
    }
}

extension YourPlacesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionView(self, collectionView: collectionView, didSelectItemAt: indexPath)
    }
}
