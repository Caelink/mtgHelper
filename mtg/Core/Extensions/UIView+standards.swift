//
//  UIView+standards.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-28.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit

class Standards: NSObject {
    static func view(with colour: UIColor) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = colour
        return view
    }
    
    static func label(showing text: String) -> UILabel {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 26.0)
        label.textAlignment = .center
        label.text = text
        return label
    }
    
    static func button(called text: String) -> UIButton {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(text, for: .normal)
        button.showsTouchWhenHighlighted = true
        button.setTitleColor(.black, for: .normal)
        return button
    }
}
