//
//  PlayerView.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-22.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit

class PlayerView: UIView {
    let identifier: Int
    var lifeCounter: UILabel = {
        let label = UILabel()
        label.text = String(describing: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 26.0)
        label.textAlignment = .center
        return label
    }()
    
    var lifeTotal: Int {
        didSet {
            self.lifeCounter.text = String(describing: lifeTotal)
        }
    }
    
    init(identifier: Int, initialLife: Int = 20) {
        self.identifier = identifier
        self.lifeTotal = initialLife
        super.init(frame: .zero)
        self.backgroundColor = InterfaceColours.rust
        self.setup()
    }
    
    func setup() {
        addSubview(lifeCounter)
        addConstraints([
            lifeCounter.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            lifeCounter.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            lifeCounter.centerXAnchor.constraint(equalTo: centerXAnchor),
            lifeCounter.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
