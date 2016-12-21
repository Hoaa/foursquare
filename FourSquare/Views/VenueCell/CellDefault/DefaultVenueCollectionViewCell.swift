//
//  DefaultVenueCollectionViewCell.swift
//  FourSquare
//
//  Created by Duy Linh on 12/16/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit
private let imageListLayoutSize: CGFloat = 80.0
class DefaultVenueCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageVenue: UIImageView!
    @IBOutlet weak var nameListVenue: UILabel!
    @IBOutlet weak var nameGridVenue: UILabel!
    @IBOutlet weak var categoryListVenue: UILabel!
    @IBOutlet weak var categoryGridVenue: UILabel!
    @IBOutlet weak var distanceToVenue: UILabel!
    @IBOutlet weak var addressVenue: UILabel!
    @IBOutlet weak var priceVenue: UILabel!
    @IBOutlet weak var rateVenue: UILabel!
    @IBOutlet weak var backgroundGradientView: UIView!
    //Image constraint
    @IBOutlet weak var imageVenueViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageVenueViewHeightConstraint: NSLayoutConstraint!
    //nameListVenue constraint
    @IBOutlet weak var nameListVenueLeadingConstraint: NSLayoutConstraint! {
        didSet {
            initialLabelsLeadingConstraintValue = nameListVenueLeadingConstraint.constant
        }
    }
    //categoryVenue constraint
    @IBOutlet weak var categoryListLeadingConstraint: NSLayoutConstraint!
    //distanceToVenue constrait
    @IBOutlet weak var distanceVenueLeadingConstraint: NSLayoutConstraint!
    
    fileprivate var imageGridLayoutSize: CGFloat = 0.0
    fileprivate var initialLabelsLeadingConstraintValue: CGFloat = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupGridLayoutConstraints(_ transitionProgress: CGFloat, cellWidth: CGFloat) {
        imageVenueViewHeightConstraint.constant = ceil((cellWidth - imageListLayoutSize) * transitionProgress + imageListLayoutSize)
        imageVenueViewWidthConstraint.constant = imageVenueViewHeightConstraint.constant
        nameListVenueLeadingConstraint.constant = -imageVenueViewWidthConstraint.constant * transitionProgress + initialLabelsLeadingConstraintValue
        categoryListLeadingConstraint.constant = nameListVenueLeadingConstraint.constant
        distanceVenueLeadingConstraint.constant = nameListVenueLeadingConstraint.constant
        backgroundGradientView.alpha = transitionProgress <= 0.5 ? 1 - transitionProgress : transitionProgress
        nameListVenue.alpha = 1 - transitionProgress
        categoryListVenue.alpha = 1 - transitionProgress
        distanceToVenue.alpha = 1 - transitionProgress
        priceVenue.alpha = 1 - transitionProgress
        distanceToVenue.alpha = 1 - transitionProgress
        addressVenue.alpha = 1 - transitionProgress
    }
    
    func setupListLayoutConstraints(_ transitionProgress: CGFloat, cellWidth: CGFloat) {
        imageVenueViewHeightConstraint.constant = ceil(imageGridLayoutSize - (imageGridLayoutSize - imageListLayoutSize) * transitionProgress)
        imageVenueViewWidthConstraint.constant = imageVenueViewHeightConstraint.constant
        nameListVenueLeadingConstraint.constant = imageVenueViewWidthConstraint.constant * transitionProgress + (initialLabelsLeadingConstraintValue - imageVenueViewHeightConstraint.constant)
        categoryListLeadingConstraint.constant = nameListVenueLeadingConstraint.constant
        distanceVenueLeadingConstraint.constant = nameListVenueLeadingConstraint.constant
        backgroundGradientView.alpha = transitionProgress <= 0.5 ? 1 - transitionProgress : transitionProgress
        nameListVenue.alpha = transitionProgress
        categoryListVenue.alpha = transitionProgress
        distanceToVenue.alpha = transitionProgress
        priceVenue.alpha = transitionProgress
        distanceToVenue.alpha = transitionProgress
        addressVenue.alpha = transitionProgress
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        guard let attributes = layoutAttributes as? DisplaySwitchLayoutAttributes else { return }
        if attributes.transitionProgress > 0 {
            if attributes.layoutState == .grid {
                setupGridLayoutConstraints(attributes.transitionProgress, cellWidth: attributes.nextLayoutCellFrame.width)
                imageGridLayoutSize = attributes.nextLayoutCellFrame.width
            } else {
                setupListLayoutConstraints(attributes.transitionProgress, cellWidth: attributes.nextLayoutCellFrame.width)
            }
        }
    }
    
}
