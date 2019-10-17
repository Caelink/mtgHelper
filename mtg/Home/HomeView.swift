//
//  HomeView.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-15.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit
import CaelinCore

protocol HomeViewDelegate {
    func homeViewDidTapPlay(view: HomeView)
    func homeViewDidTapTrade(view: HomeView)
    func homeViewDidTapLookup(view: HomeView)
}

class HomeView: UIView {
    let delegate: HomeViewDelegate
    var playButton: PrimaryButton = PrimaryButton(text: "Play", colour: InterfaceColours.green)
    var lookupButton: PrimaryButton = PrimaryButton(text: "Lookup", colour: InterfaceColours.orange)
    var tradeButton: PrimaryButton = PrimaryButton(text: "Trade", colour: InterfaceColours.lightBlue)
    
    var menuScreenTitleLabel: UILabel = {
        let label = Standards.label(showing: "Caelin's MTG Helper App")
        label.numberOfLines = 0
        return label
    }()
    
    init(delegate: HomeViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        self.setup()
    }
    
    func setup() {
        addSubview(menuScreenTitleLabel)
        addConstraints([
            menuScreenTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            menuScreenTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            menuScreenTitleLabel.centerYAnchor.constraint(equalTo: topAnchor, constant: 200)
        ])
        
        verticalCascadeLayout(of: [playButton, lookupButton, tradeButton], from: centerYAnchor, margin: 20)
        
        playButton.addAction(for: .touchUpInside) { [unowned self] in
            self.delegate.homeViewDidTapPlay(view: self)
        }
        
        lookupButton.addAction(for: .touchUpInside) { [unowned self] in
            self.delegate.homeViewDidTapLookup(view: self)
        }
        
        tradeButton.isEnabled = false
        tradeButton.addAction(for: .touchUpInside) { [unowned self] in
            self.delegate.homeViewDidTapTrade(view: self)
        }
    }
    
    // MARK: Annoying Boilerplate
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
