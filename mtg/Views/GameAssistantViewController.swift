//
//  GameAssistantViewController.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-22.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit

class GameAssistantViewController: UIViewController {
    var gameAssistantView: GameAssistantView?
    
    convenience init() {
        // Boilerplate 'empty' initialize to save other boilerplate
        self.init(nibName: nil, bundle: nil)
        gameAssistantView = GameAssistantView(delegate: self)
    }
    
    override func loadView() {
        super.loadView()
        view = gameAssistantView
    }
}

extension GameAssistantViewController: GameAssistantViewDelegate {
    func gameAssistant(view: GameAssistantView, changedLifeTotalForPlayerAtIndex: Int, by: Int) {
        /* No-op */
    }
}
