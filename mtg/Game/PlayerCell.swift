//
//  PlayerView.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-22.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit
import CaelinCore

protocol PlayerCellDelegate {
    func player(cell: PlayerCell, took action:PlayerCell.Action)
}

class PlayerCell: UICollectionViewCell {
    var delegate: PlayerCellDelegate?
    var currentPlayer: Player?
    var touchStarted: Date?
    
    let title: UILabel = Standards.label(showing: "Player ?")
    let lifeCounter: UILabel = Standards.label(showing: String(describing: 20))
    let plus: UILabel = Standards.label(showing: "+")
    let minus: UILabel = Standards.label(showing: "-")
    let actions: UIButton = Standards.button(called: "...")
    
    let tapBounds: UIView = Standards.view(base: .black)
    var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        return recognizer
    }()
    
    var longPressGestureRecognizer: UILongPressGestureRecognizer = {
        let recognizer = UILongPressGestureRecognizer()
        return recognizer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setup()
    }
    
    func setup() {
        let middle = Standards.stack(showing: [minus, actions, plus], along: .horizontal)
        let overall = Standards.stack(showing: [title, middle, lifeCounter], along: .vertical)
        addSubview(overall)
        snapToBounds(view: overall, leaving: 30)
        
        overall.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.addTarget(self, action: #selector(PlayerCell.received(tap:)))
        
        overall.addGestureRecognizer(longPressGestureRecognizer)
        longPressGestureRecognizer.addTarget(self, action: #selector(PlayerCell.received(press:)))
        
        actions.addAction(for: .touchUpInside) { [unowned self] in
            self.delegate?.player(cell: self, took: .moreOptions)
        }
    }
    
    // MARK: Annoying Boilerplate
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PlayerCell {
    enum Action {
        case tapLeft
        case tapRight
        case longTapLeft
        case longTapRight
        case moreOptions
    }
    
    @objc func received(tap gestureRecognizer: UITapGestureRecognizer) {
        guard let delegate = delegate else {
            return
        }
        let action: PlayerCell.Action
        let halfway = bounds.width / 2
        let tap = gestureRecognizer.location(in: self)
        if (tap.x < halfway) {
            action = .tapLeft
        } else {
            action = .tapRight
        }
        
        if gestureRecognizer.state == .ended {
            delegate.player(cell: self, took: action)
//            animate(touch: tap)
        }
    }
    
    @objc func received(press gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(ofTouch: 0, in: self)
        switch gestureRecognizer.state {
        case .began:
            startLongPressAnimation(at: location)
            break
        case .changed:
            break
        case .possible:
            break
        case .ended:
            fallthrough
        case .cancelled:
            fallthrough
        case .failed:
            fallthrough
        @unknown default:
            endLongPressAnimation()
        }
    }
    
    func animate(touch center: CGPoint) {
        let touchRipple: UIView = Standards.view(base: ColourWheel.black)
        let radius: CGFloat = 10
        touchRipple.frame = CGRect(x: center.x - radius,
                                   y: center.y - radius,
                                   width: 2*radius,
                                   height: 2*radius)
        touchRipple.layer.cornerRadius = radius
        touchRipple.alpha = 0.7
        addSubview(touchRipple)
        UIView.animate(withDuration: 0.2,
                       animations: {
                        touchRipple.transform = CGAffineTransform(scaleX: 5, y: 5)
                        touchRipple.alpha = 0.4
        },
                       completion: { _ in
                        touchRipple.removeFromSuperview()
        })
    }
    
    func startLongPressAnimation(at location: CGPoint) {
        touchStarted = Date()
        addSubview(tapBounds)
        let radius: CGFloat = 40
        tapBounds.frame = CGRect(origin: CGPoint(x: location.x - radius, y: location.y - radius),
                                 size: CGSize(width: 2 * radius, height: 2 * radius))
        tapBounds.layer.cornerRadius = radius

        let halfway = bounds.width / 2
        longPressAnimate(action: location.x < halfway ? .longTapLeft : .longTapRight)
    }
    
    func longPressAnimate(action: PlayerCell.Action) {
        UIView.animate(withDuration: 1,
                       animations: { [weak self] in
                        self?.tapBounds.transform = CGAffineTransform(scaleX: 2, y: 2)
            },
                       completion: { [weak self] (completed) in
                        guard let `self` = self else {
                            return
                        }
                        self.tapBounds.transform = .identity
                        if (completed) {
                            self.longPressAnimate(action: action)
                            self.delegate?.player(cell: self, took: action)
                        }
        })
    }
    
    func endLongPressAnimation() {
        touchStarted = nil
        tapBounds.removeFromSuperview()
    }
}

// MARK: Ghetto MVVM
extension PlayerCell: Configurable {
    func update(from player: Player) {
        self.currentPlayer = player
        self.title.text = player.name ?? "Player \(player.identifier)"
        self.lifeCounter.text = String(describing: player.life)
        self.backgroundColor = player.colour
    }
}
