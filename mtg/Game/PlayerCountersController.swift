//
//  PlayerCountersController.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-09-06.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit

class PlayerCountersController: UIViewController {
    init(for player: Player) {
        super.init(nibName: nil, bundle: nil)
        self.view = UIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
