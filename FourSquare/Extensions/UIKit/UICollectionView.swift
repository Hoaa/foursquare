//
//  UICollectionView.swift
//  FourSquare
//
//  Created by Duy Linh on 12/16/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit
extension UICollectionView {
    public func registerNib<T: UICollectionViewCell>(aClass: T.Type) {
        let name = String(describing: aClass)
        let nib = UINib(nibName: name, bundle: nil)
        register(nib, forCellWithReuseIdentifier: name)
    }
    
    public func registerClass<T: UICollectionViewCell>(aClass: T.Type) {
        let name = String(describing: aClass)
        register(aClass, forCellWithReuseIdentifier: name)
    }
    
    public func dequeue<T: UICollectionViewCell>(aClass: T.Type, forIndexPath indexPath: IndexPath) -> T! {
        return dequeueReusableCell(withReuseIdentifier: String(describing: aClass), for: indexPath) as? T
    }
}
