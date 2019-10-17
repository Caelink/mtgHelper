//
//  CardRecognition.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2019-05-26.
//  Copyright © 2019 Caelin Jackson-King. All rights reserved.
//

import Foundation
import AVFoundation

struct CardMatch {
    let confidence: Double
    let name: String
}

class CardRecognitionManager {
    init() {
    }
    
    func cards(in sampleBuffer:CMSampleBuffer) -> [CardMatch] {
        return [CardMatch(confidence: 0.0, name: "Fake Test Card")]
    }
}
