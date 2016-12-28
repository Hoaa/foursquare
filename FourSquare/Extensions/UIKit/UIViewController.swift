//
//  UIViewController.swift
//  FourSquare
//
//  Created by Duy Linh on 12/16/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

extension UIViewController {
    public static func vc() -> Self {
        return self.init(nibName: String(describing: self), bundle: nil)
    }
}
