//
//  ViewController.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-15.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var homeView: HomeView?
    
    convenience init() {
        // Boilerplate 'empty' initialize to save other boilerplate
        self.init(nibName: nil, bundle: nil)
        homeView = HomeView(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func loadView() {
        super.loadView()
        view = homeView
    }
}

extension HomeViewController: HomeViewDelegate {
    func homeViewDidTapPlay(view: HomeView) {
        let settings = GameSettings(life: 20, players: 2)
        navigationController?.pushViewController(GameAssistantViewController(with: settings), animated: true)
    }
    
    func homeViewDidTapTrade(view: HomeView) {
        /* No-op */
    }
    
    func homeViewDidTapLookup(view: HomeView) {
        navigationController?.pushViewController(TradeViewController(), animated: true)
    }
}
