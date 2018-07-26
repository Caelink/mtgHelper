//
//  PlayerView.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-22.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit

struct Player {
    let identifier: Int
    var colour: UIColor = .white
    var life: Int = 20
    var infect: Int = 0
    var floating: ManaPool = ManaPool()
    
    init(with identifier: Int) {
        self.identifier = identifier
    }
}

extension Player {
    mutating func changeLife(by: Int) {
        life += by
    }
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return  lhs.identifier == rhs.identifier &&
            lhs.colour == rhs.colour &&
            lhs.life == rhs.life &&
            lhs.infect == rhs.infect &&
            lhs.floating == rhs.floating
    }
}

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
        let label = UILabel()
        label.text = String(describing: 20)
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 26.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        self.title.text = "Player \(player.identifier)"
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
        if (gestureRecognizer.location(in: self).x < halfway) {
            action = .tapLeft
        } else {
            action = .tapRight
        }
        delegate.player(cell: self, took: action)
    }
}
