//
//  Options.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-28.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import Foundation

struct GameSettings {
    let lifeTotal: Int
    let players: Int
    
    init(life: Int = 20, players: Int = 2) {
        self.lifeTotal = life
        self.players = players
    }
}
