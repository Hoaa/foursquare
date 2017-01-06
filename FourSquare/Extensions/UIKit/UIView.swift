//
//  UIView.swift
//  FourSquare
//
//  Created by nmint8m on 23.12.16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

extension UIView {
    func applyGradientLayerHorizontal(firstColor: UIColor, secondColor: UIColor) {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        self.layer.addSublayer(gradientLayer)
    }
    
    func applyGradientLayerVetical(firstColor: UIColor, secondColor: UIColor) {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        self.layer.addSublayer(gradientLayer)
    }
    
    func conerRadiusWith(value: CGFloat) {
        self.layer.cornerRadius = value
        self.layer.masksToBounds = true
    }
}
