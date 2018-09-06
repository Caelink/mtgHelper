//
//  Configurable.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-09-06.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import Foundation

protocol Configurable {
    associatedtype T
    func update(from configuration: T)
}
