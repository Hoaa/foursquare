//
//  UIView.swift
//  FourSquare
//
//  Created by nmint8m on 23.12.16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

extension UIView {
    func applyGradientLayer(firstColor: UIColor, secondColor: UIColor) {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        gradientLayer.colors = [firstColor.cgColor, firstColor.cgColor, secondColor.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        self.layer.addSublayer(gradientLayer)
    }
}
