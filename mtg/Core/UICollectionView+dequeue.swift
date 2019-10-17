//
//  UICollectionViewCell+dequeue.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-25.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UICollectionViewCell: ReusableView {
}
