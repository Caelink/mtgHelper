//
//  TradeView.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2019-05-26.
//  Copyright © 2019 Caelin Jackson-King. All rights reserved.
//

import CaelinCore
import UIKit
import AVFoundation

protocol TradeViewDelegate {
    /* Methods to pass actions back up to the controller for processing */
}

class TradeView: UIView {
    let delegate: TradeViewDelegate
//    let preview: PreviewView
    
    init(delegate: TradeViewDelegate) {
        self.delegate = delegate
//        preview = PreviewView()
        super.init(frame: .zero)
        setup()
    }
    
    func setup() {
    }
    
    func preview(session: AVCaptureSession) {
//        preview.preview(session: session)
    }
    
    // MARK: Annoying Boilerplate
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
