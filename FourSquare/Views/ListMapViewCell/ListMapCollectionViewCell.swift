//
//  ListMapCollectionViewCell.swift
//  FourSquare
//
//  Created by nmint8m on 14.12.16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

class ListMapCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var venueImageView: UIImageView!
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var venueCategoryLabel: UILabel!
    @IBOutlet weak var venueExpensiveLabel: UILabel!
    @IBOutlet weak var venueDistanceLabel: UILabel!
    @IBOutlet weak var venueAddressLabel: UILabel!
    @IBOutlet weak var venueRateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
