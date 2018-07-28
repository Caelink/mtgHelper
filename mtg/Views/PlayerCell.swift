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
    
    var title: UILabel = {
        let label = UILabel()
        label.text = "Player ?"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 26.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var lifeCounter: UILabel = {
        let tf = UILabel()
        tf.text = String(describing: 20)
        tf.font = UIFont.systemFont(ofSize: 26.0)
        tf.textAlignment = .center
        tf.numberOfLines = 1
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        return recognizer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setup()
    }
    
    func update(from player: Player) {
        self.currentPlayer = player
        self.title.text = player.name ?? "Player \(player.identifier)"
        self.lifeCounter.text = String(describing: player.life)
        self.backgroundColor = player.colour
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
        
        addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.addTarget(self, action: #selector(PlayerCell.received(tap:)))
        
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
    }
    
    @objc func received(tap gestureRecognizer: UITapGestureRecognizer) {
        guard let delegate = delegate,
        gestureRecognizer.state == .ended else {
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
        delegate.player(cell: self, took: action)
    }
}
