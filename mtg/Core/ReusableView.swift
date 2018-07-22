//
//  File.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-22.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit

protocol ReusableView {
    func buildConstraints() -> [NSLayoutConstraint]
}
