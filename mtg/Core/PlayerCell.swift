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

class PlayerCell: UICollectionViewCell {
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
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let titleSize = title.sizeThatFits(size)
        let lifeSize = lifeCounter.sizeThatFits(size)
        return CGSize(width: max(titleSize.width, lifeSize.width), height: titleSize.height + lifeSize.height + 10)
    }
    
    // MARK: Annoying Boilerplate
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
