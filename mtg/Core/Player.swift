//
//  Player.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-28.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit

struct Player {
    let identifier: Int
    var name: String?
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
