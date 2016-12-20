//
//  FeatureView.swift
//  FourSquare
//
//  Created by nmint8m on 16.12.16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

protocol FeatureViewDataSource {
    func numberOfSections(_ view: UIView, collectionView: UICollectionView) -> Int
    func collectionView(_ view: UIView, collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ view: UIView, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

protocol FeatureViewDelegate {
    func collectionView(_ view: UIView, collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

class FeatureView: UIView {

    var datasource: FeatureViewDataSource?
    var delegate: FeatureViewDelegate?
    
    @IBOutlet weak var featureCollectionView: UICollectionView!
    
    func configureView() {
        // Frame
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: self.bounds.width - 10, height: self.bounds.height - 10)
        layout.scrollDirection = .horizontal
        featureCollectionView.collectionViewLayout = layout
        featureCollectionView.isPagingEnabled = true
        
        // Register
        let nibForFeature = UINib(nibName: "FeatureCollectionViewCell", bundle: nil)
        featureCollectionView.register(nibForFeature, forCellWithReuseIdentifier: "FeatureCollectionViewCell")
        
        // DataSource and delegate
        featureCollectionView.dataSource = self
        featureCollectionView.delegate = self
    }
}

extension FeatureView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let numberOfSections = datasource?.numberOfSections(self, collectionView: collectionView) {
            return numberOfSections
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let numberItemsInSection = datasource?.collectionView(self, collectionView: collectionView, numberOfItemsInSection: section) {
            return numberItemsInSection
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cellForItem = datasource?.collectionView(self, collectionView: collectionView, cellForItemAt: indexPath) {
            return cellForItem
        }
        return UICollectionViewCell()
    }
}

extension FeatureView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionView(self, collectionView: collectionView, didSelectItemAt: indexPath)
    }
}
