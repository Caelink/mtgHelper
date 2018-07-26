//
//  GameAssistantView.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-22.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit

protocol GameAssistantViewDelegate: UICollectionViewDelegate, UICollectionViewDataSource {
    func gameAssistant(view: GameAssistantView, changedLifeTotalForPlayerAt index: Int, by amount: Int)
}

class GameAssistantView: UIView {
    let delegate: GameAssistantViewDelegate
    var players: UICollectionView = {
        let collection = UICollectionView()
        return collection
    }()
    
    init(delegate: GameAssistantViewDelegate, players: Int = 2) {
        assert(players == 2, "Sorry, only 2 players supported at the moment!")
        self.delegate = delegate
        self.players.delegate = delegate
        self.players.dataSource = delegate
        super.init(frame: .zero)
        self.setup()
    }
    
    func setup() {
        self.backgroundColor = .green
    }
    
    // MARK: Annoying Boilerplate
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
