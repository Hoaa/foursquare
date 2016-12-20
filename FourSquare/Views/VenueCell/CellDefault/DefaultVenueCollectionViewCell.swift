//
//  DefaultVenueCollectionViewCell.swift
//  FourSquare
//
//  Created by Duy Linh on 12/16/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

class DefaultVenueCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageVenue: UIImageView!
    @IBOutlet weak var nameVenue: UILabel!
    @IBOutlet weak var categoryVenue: UILabel!
    @IBOutlet weak var distanceToVenue: UILabel!
    @IBOutlet weak var addressVenue: UILabel!
    @IBOutlet weak var priceVenue: UILabel!
    @IBOutlet weak var rateVenue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
