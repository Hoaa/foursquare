//
//  UIColor.swift
//  FourSquare
//
//  Created by Duy Linh on 12/16/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit
extension UIColor {
    public class func RGB(red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat = 1) -> UIColor {
        let red = max(0.0, min(CGFloat(red) / 255.0, 1.0))
        let green = max(0.0, min(CGFloat(green) / 255.0, 1.0))
        let blue = max(0.0, min(CGFloat(blue) / 255.0, 1.0))
        let alpha = max(0.0, min(alpha, 1.0))
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
