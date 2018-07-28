//
//  GameAssistantViewController.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-22.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit

class GameAssistantViewController: UIViewController {
    var players: [Player] = []
    var gameAssistantView: GameAssistantView?
    
    convenience init(players: Int) {
        self.init()
        self.players = (0..<players).map({ (identifier) -> Player in
            var p = Player(with: identifier)
            if players == 2 {
                let isMe = identifier == 0
                p.name = isMe ? "Me" : "You"
                p.colour = isMe ? InterfaceColours.green : InterfaceColours.rust
            }
            return p
        })
        self.gameAssistantView = GameAssistantView(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func loadView() {
        super.loadView()
        view = gameAssistantView
    }
}

// MARK: UICollectionViewDataSource
extension GameAssistantViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        assert(indexPath.row < players.count)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerCell.defaultReuseIdentifier, for: indexPath) as? PlayerCell else {
            fatalError("Couldn't convert to PlayerCell")
        }
        cell.update(from: players[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? players.count : 0
    }
}

extension GameAssistantViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let seperatorCount: CGFloat = CGFloat(players.count)
        let height: CGFloat = (collectionView.bounds.height - GameAssistantView.playerCellMargin * seperatorCount) / seperatorCount
        return CGSize(width: collectionView.bounds.size.width, height: height)
    }
}

extension GameAssistantViewController: GameAssistantViewDelegate {
    func gameAssistantTappedOptions(view: GameAssistantView) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "End Game", style: .destructive, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Roll d6", style: .default, handler: { _ in
            let result = Int.random(in: 1..<7)
            let alert = UIAlertController(title: "Dice Rolled", message: "You rolled a \(result)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                alert.dismiss(animated: false, completion: nil)
            }))
            self.present(alert, animated: false, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: PlayerCellDelegate
extension GameAssistantViewController: PlayerCellDelegate {
    func player(cell: PlayerCell, took action: PlayerCell.Action) {
        guard let id = cell.currentPlayer?.identifier else {
            return
        }
        
        let delta: Int
        switch action {
        case .tapLeft:
            delta = -1
            break;
        case .longTapLeft:
            delta = -10
            break;
        case .tapRight:
            delta = 1
            break;
        case .longTapRight:
            delta = 10
            break;
        }
        
        players[id].changeLife(by: delta)
        cell.update(from: players[id])
    }
}
