//
//  VenueTableViewCell.swift
//  FourSquare
//
//  Created by nmint8m on 21.12.16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

class VenueTableViewCell: UITableViewCell {

    @IBOutlet weak var venueImageView: UIImageView!
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var venueAdressLabel: UILabel!
    @IBOutlet weak var rateColorImageView: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
