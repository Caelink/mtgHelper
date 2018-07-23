//
//  GameAssistantView.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-22.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit

protocol GameAssistantViewDelegate {
    func gameAssistant(view: GameAssistantView, changedLifeTotalForPlayerAt index: Int, by amount: Int)
}

class GameAssistantView: UIView {
    let delegate: GameAssistantViewDelegate
    var players: [PlayerView]
    
    init(delegate: GameAssistantViewDelegate, players: Int = 2) {
        assert(players == 2, "Sorry, only 2 players supported at the moment!")
        self.delegate = delegate
        self.players = (0..<players).map({ (identifier) -> PlayerView in
            PlayerView(identifier: identifier, initialLife: 20)
        })
        super.init(frame: .zero)
        self.setup()
    }
    
    func setup() {
        self.backgroundColor = .green
        verticalCascadeLayout(of: players, from: safeAreaLayoutGuide.topAnchor, margin: 0)
        for player in players {
            addConstraints([
                player.leftAnchor.constraint(equalTo: leftAnchor),
                player.rightAnchor.constraint(equalTo: rightAnchor)
            ])
        }
        if let last = players.last {
            addConstraint(last.bottomAnchor.constraint(equalTo: bottomAnchor))
        }
    }
    
    // MARK: Annoying Boilerplate
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
