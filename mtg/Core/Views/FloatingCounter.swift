//
//  File.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-09-06.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit
import CaelinCore

struct Counter {
    var name: String
    var value: Int
    init(name: String, value: Int) {
        self.name = name
        self.value = value
    }
}

extension Counter: Equatable {
    static func ==(lhs: Counter, rhs: Counter) -> Bool {
        return lhs.name == rhs.name && lhs.value == rhs.value
    }
}

class FloatingCounter: UIView {
    static let height: CGFloat  = 50
    static let width: CGFloat   = 100
    let name: UILabel
    let count: UILabel
    
    init(from counter: Counter) {
        self.name = Standards.label(showing: counter.name)
        self.count = Standards.label(showing: String(counter.value))
        super.init(frame: .zero)
        self.backgroundColor = InterfaceColours.offwhite
        self.setup()
    }
    
    func setup() {
        addSubview(name)
        addConstraints([
            name.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            name.centerXAnchor.constraint(equalTo: centerXAnchor),
            name.topAnchor.constraint(equalTo: topAnchor, constant: 5)
        ])
        
        addSubview(count)
        addConstraints([
            count.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            count.centerXAnchor.constraint(equalTo: centerXAnchor),
            count.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
            count.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5)
        ])
    }
    
    // MARK: Annoying Boilerplate
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FloatingCounter: OpinionatedView {
    func buildConstraints() -> [NSLayoutConstraint] {
        guard superview != nil else {
            return []
        }
        
        return [
            heightAnchor.constraint(equalToConstant: FloatingCounter.height),
            widthAnchor.constraint(equalToConstant: FloatingCounter.width)
        ]
    }
}

// MARK: Ghetto MVVM
extension FloatingCounter: Configurable {
    func update(from counter: Counter) {
        self.name.text = counter.name
        self.count.text = String(counter.value)
    }
}
