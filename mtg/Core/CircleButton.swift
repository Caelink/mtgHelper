//
//  CircleButton.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-28.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit

class CircleButton: UIButton {
    static let diameter: CGFloat = 50
    
    let colour: UIColor
    
    override var isEnabled: Bool {
        didSet {
            self.backgroundColor = isEnabled ? colour : InterfaceColours.steel
        }
    }
    
    init(colour: UIColor = InterfaceColours.steel) {
        self.colour = colour
        super.init(frame: .zero)
        self.layer.cornerRadius = CircleButton.diameter / 2
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = colour
        self.translatesAutoresizingMaskIntoConstraints = false
        self.showsTouchWhenHighlighted = true
    }
    
    // MARK: Annoying Boilerplate
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CircleButton: OpinionatedView {
    func buildConstraints() -> [NSLayoutConstraint] {
        guard superview != nil else {
            return []
        }
        
        return [
            heightAnchor.constraint(equalToConstant: CircleButton.diameter),
            widthAnchor.constraint(equalToConstant: CircleButton.diameter)
        ]
    }
}
