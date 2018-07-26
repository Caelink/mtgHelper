//
//  Mana.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-25.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import Foundation

struct ManaPool {
    var amounts: [Int]
    enum Mana: Int {
        case white = 0
        case blue = 1
        case black = 2
        case red = 3
        case green = 4
        case colourless = 5
        case generic = 6
    }
    
    mutating func clear() {
        amounts = (0..<7).map { (mana) -> Int in
            return 0
        }
    }
    
    mutating func add(amount: Int, of type: Mana) {
        amounts[type.rawValue] += amount
    }
    
    init() {
        amounts = (0..<7).map { (mana) -> Int in
            return 0
        }
    }
    
    init(amounts: [Int]) {
        assert(amounts.count == 7)
        self.amounts = amounts
    }
}
