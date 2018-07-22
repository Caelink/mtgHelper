//
//  GameAssistantView.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-22.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit

protocol GameAssistantViewDelegate {
    func gameAssistant(view: GameAssistantView, changedLifeTotalForPlayerAtIndex: Int, by: Int)
}

class GameAssistantView: UIView {
    let delegate: GameAssistantViewDelegate
    var players: [PlayerView]
    
    init(delegate: GameAssistantViewDelegate, players: Int = 2) {
        assert(players != 2, "Sorry, only 2 players supported at the moment!")
        self.delegate = delegate
        self.players = (0..<players).map({ (identifier) -> PlayerView in
            PlayerView(identifier: identifier, initialLife: 20)
        })
        super.init(frame: .zero)
        self.setup()
    }
    
    func setup() {
        cascadeLayoutOf(views:players)
    }
    
    // MARK: Annoying Boilerplate
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GameAssistantView {
    func cascadeLayoutOf(views: [UIView]) {
        var previousAnchor: NSLayoutAnchor = topAnchor
        for view in views {
            addSubview(view)
            addConstraints([
                view.topAnchor.constraint(equalTo: previousAnchor),
                view.leftAnchor.constraint(equalTo: leftAnchor),
                view.rightAnchor.constraint(equalTo: rightAnchor)
            ])
            previousAnchor = view.bottomAnchor
        }
        if let lastView = views.last {
            addConstraint(lastView.bottomAnchor.constraint(equalTo: bottomAnchor))
        }
    }
}
