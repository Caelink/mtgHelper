//
//  TradeViewController.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2019-05-26.
//  Copyright © 2019 Caelin Jackson-King. All rights reserved.
//

import UIKit
import AVFoundation

class TradeViewController: UIViewController {
    var tradeView: TradeView?
    let session: AVCaptureSession
    let recognitionManager: CardRecognitionManager
    
    init() {
        recognitionManager = CardRecognitionManager()
        session = AVCaptureSession()
        session.sessionPreset = .high
        guard let rearCamera = AVCaptureDevice.default(for: .video) else {
            fatalError("Couldn't get reference to back camera")
        }
        do {
            let input = try AVCaptureDeviceInput(device: rearCamera)
            if (session.canAddInput(input)) {
                session.addInput(input)
            }
        } catch {
            fatalError("Failed to get input from back camera")
        }

        super.init(nibName: nil, bundle: nil)
        tradeView = TradeView(delegate: self)
        
        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "Card Lookup"))
        if (session.canAddOutput(output)) {
            session.addOutput(output)
            tradeView?.preview(session: session)
        }
    }
    
    // Least boilerplate without using initializer antipatterns
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        DispatchQueue.main.async { [weak self] in
            self?.session.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session.stopRunning()
    }
    
    override func loadView() {
        super.loadView()
        view = tradeView
    }
}

extension TradeViewController: TradeViewDelegate {
}

extension TradeViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let cards = recognitionManager.cards(in: sampleBuffer)
        if (cards.count == 1) {
            print("Recognized \(cards[0].name) with confidence \(cards[0].confidence)")
        } else if (cards.count > 1) {
            print("2 or more cards in image!")
        }
    }
}
