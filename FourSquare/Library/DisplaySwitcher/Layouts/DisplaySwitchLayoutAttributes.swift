//
//  DisplaySwitchLayoutAttributes.swift
//  FourSquare
//
//  Created by Duy Linh on 12/20/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit
open class DisplaySwitchLayoutAttributes: UICollectionViewLayoutAttributes {
    
    open var transitionProgress: CGFloat = 0.0
    open var nextLayoutCellFrame: CGRect = .zero
    open var layoutState: LayoutState = .list
    
    override open func copy(with zone: NSZone?) -> Any {
        let copy = super.copy(with: zone) as! DisplaySwitchLayoutAttributes
        copy.transitionProgress = transitionProgress
        copy.nextLayoutCellFrame = nextLayoutCellFrame
        copy.layoutState = layoutState
        return copy
    }
    
    override open func isEqual(_ object: Any?) -> Bool {
        guard let attributes = object as? DisplaySwitchLayoutAttributes else { return false }
        guard attributes.transitionProgress == transitionProgress && nextLayoutCellFrame == nextLayoutCellFrame && layoutState == layoutState else { return false }
        return super.isEqual(object)
    }
}

