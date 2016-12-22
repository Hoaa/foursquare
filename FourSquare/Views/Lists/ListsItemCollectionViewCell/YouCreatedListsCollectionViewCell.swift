//
//  FeatureCollectionViewCell.swift
//  FourSquare
//
//  Created by nmint8m on 15.12.16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

class ListsItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imagesContainerView: UIView!
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var numberPlacesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
