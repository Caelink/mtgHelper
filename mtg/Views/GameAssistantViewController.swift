//
//  GameAssistantViewController.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-22.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit

class GameAssistantViewController: UICollectionViewController {
    var players: [Player] = []
    var wrapperView: UIView = UIView()
    
    convenience init(players: Int) {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 5, left: 5, bottom: 5, right: 5)
        self.init(collectionViewLayout: layout)
        self.players = (0..<players).map({ (identifier) -> Player in
            return Player(with: identifier)
        })
        collectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(PlayerCell.self, forCellWithReuseIdentifier: PlayerCell.defaultReuseIdentifier)
        view.backgroundColor = .white
    }
}

//MARK: UICollectionViewDataSource
extension GameAssistantViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        assert(indexPath.row < players.count)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerCell.defaultReuseIdentifier, for: indexPath) as? PlayerCell else {
            fatalError("Couldn't convert to PlayerCell")
        }
        cell.update(from: players[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? players.count : 0
    }
}

extension GameAssistantViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = (collectionView.bounds.height - CGFloat(10 * players.count)) / CGFloat(players.count)
        return CGSize(width: collectionView.bounds.size.width, height: height)
    }
}
