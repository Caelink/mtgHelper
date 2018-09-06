//
//  UIView+CascadingSubviews.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-22.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit

extension UIView {
    func verticalCascadeLayout(of views: [UIView], from anchor: NSLayoutYAxisAnchor, margin: CGFloat) {
        guard let first = views.first else {
            return
        }
        var previousAnchor: NSLayoutAnchor = anchor
        for view in views {
            addSubview(view)
            if let opinionatedView = view as? OpinionatedView {
                addConstraints(opinionatedView.buildConstraints())
            }
            addConstraints([
                view.topAnchor.constraint(equalTo: previousAnchor, constant: margin),
                view.heightAnchor.constraint(equalTo: first.heightAnchor)
            ])
            previousAnchor = view.bottomAnchor
        }
    }
    
    func snapToBounds(view: UIView) {
        addConstraints([
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
