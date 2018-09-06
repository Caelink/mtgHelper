//
//  GameAssistantView.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-28.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit

protocol GameAssistantViewDelegate: UICollectionViewDelegate, UICollectionViewDataSource {
    func gameAssistantTappedOptions(view: GameAssistantView)
}

class GameAssistantView: UIView {
    static let playerCellMargin: CGFloat = 2
    let delegate: GameAssistantViewDelegate
    let collectionView: UICollectionView
    static func createCollectionView(delegate: GameAssistantViewDelegate) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = GameAssistantView.playerCellMargin
        layout.minimumLineSpacing = GameAssistantView.playerCellMargin
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isScrollEnabled = false
        cv.backgroundColor = .black
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = delegate
        cv.dataSource = delegate
        return cv
    }
    
    lazy var optionsButton: CircleButton = CircleButton(colour: InterfaceColours.lightBlue)
    
    init(delegate: GameAssistantViewDelegate) {
        self.delegate = delegate
        self.collectionView = GameAssistantView.createCollectionView(delegate: delegate)
        super.init(frame: .zero)
        self.setup()
    }
    
    func setup() {
        self.backgroundColor = InterfaceColours.offwhite
        addSubview(collectionView)
        addConstraints([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            collectionView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor)
        ])
        collectionView.register(PlayerCell.self, forCellWithReuseIdentifier: PlayerCell.defaultReuseIdentifier)
        
        addSubview(optionsButton)
        addConstraints(optionsButton.buildConstraints() + [
            optionsButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            optionsButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
        optionsButton.addAction(for: .touchUpInside) { [unowned self] in
            self.delegate.gameAssistantTappedOptions(view: self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Floating Counter support
extension GameAssistantView {
    func addCounterView(_ counter: FloatingCounter) {
        addSubview(counter)
        addConstraints(counter.buildConstraints())
    }
}
