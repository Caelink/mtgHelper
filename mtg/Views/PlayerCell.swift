//
//  PlayerView.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-22.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit

protocol PlayerCellDelegate {
    func player(cell: PlayerCell, took action:PlayerCell.Action)
}

class PlayerCell: UICollectionViewCell {
    var delegate: PlayerCellDelegate?
    var currentPlayer: Player?
    
    let title: UILabel = Standards.label(showing: "Player ?")
    let lifeCounter: UILabel = Standards.label(showing: String(describing: 20))
    let plus: UILabel = Standards.label(showing: "+")
    let minus: UILabel = Standards.label(showing: "-")
    let actions: UIButton = Standards.button(called: "...")
    
    let tapBounds: UIView = Standards.view(with: .clear)
    var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        return recognizer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setup()
    }
    
    func setup() {
        verticalCascadeLayout(of: [title, lifeCounter], from: topAnchor, margin: 10)
        addConstraints([
            title.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            title.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            lifeCounter.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            lifeCounter.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            lifeCounter.bottomAnchor.constraint(equalTo: bottomAnchor),
            lifeCounter.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        title.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
        title.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        lifeCounter.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
        lifeCounter.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        
        addSubview(plus)
        addSubview(minus)
        addConstraints([
            minus.leftAnchor.constraint(equalTo: leftAnchor),
            minus.rightAnchor.constraint(equalTo: centerXAnchor),
            plus.leftAnchor.constraint(equalTo: centerXAnchor),
            plus.rightAnchor.constraint(equalTo: rightAnchor),
            plus.topAnchor.constraint(equalTo: topAnchor),
            plus.bottomAnchor.constraint(equalTo: bottomAnchor),
            minus.topAnchor.constraint(equalTo: topAnchor),
            minus.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        addSubview(tapBounds)
        snapToBounds(view: tapBounds)
        tapBounds.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.addTarget(self, action: #selector(PlayerCell.received(tap:)))
        
        addSubview(actions)
        bringSubviewToFront(actions)
        actions.addAction(for: .touchUpInside) { [unowned self] in
            self.delegate?.player(cell: self, took: .moreOptions)
        }
        addConstraints([
            actions.centerXAnchor.constraint(equalTo: centerXAnchor),
            actions.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        self.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: Annoying Boilerplate
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PlayerCell {
    enum Action {
        case tapLeft
        case tapRight
        case longTapLeft
        case longTapRight
        case moreOptions
    }
    
    @objc func received(tap gestureRecognizer: UITapGestureRecognizer) {
        guard let delegate = delegate else {
                return
        }
        let action: PlayerCell.Action
        let halfway = bounds.width / 2
        let tap = gestureRecognizer.location(in: self)
        if (tap.x < halfway) {
            action = .tapLeft
        } else {
            action = .tapRight
        }
        
        if gestureRecognizer.state == .ended {
            delegate.player(cell: self, took: action)
        }
    }
}

// MARK: Ghetto MVVM
extension PlayerCell: Configurable {
    func update(from player: Player) {
        self.currentPlayer = player
        self.title.text = player.name ?? "Player \(player.identifier)"
        self.lifeCounter.text = String(describing: player.life)
        self.backgroundColor = player.colour
    }
}
