//
//  Colours.swift
//  mtg
//
//  Created by Caelin Jackson-King on 2018-07-22.
//  Copyright © 2018 Caelin Jackson-King. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        guard red < 256, green < 256, blue < 256 else {
            self.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            return
        }
        
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }
}

struct ColourWheel {
    static var white: UIColor { return UIColor(red: 255, green: 252, blue: 235) }
    static var blue: UIColor { return UIColor(red: 166, green: 222, blue: 250) }
    static var black: UIColor { return UIColor(red: 213, green: 207, blue: 207) }
    static var red: UIColor { return UIColor(red: 250, green: 180, blue: 147) }
    static var green: UIColor { return UIColor(red: 166, green: 222, blue: 187) }
}

struct InterfaceColours {
    static var green: UIColor { return UIColor(red: 40, green: 190, blue: 155) }
    static var lightBlue: UIColor { return UIColor(red: 146, green: 220, blue: 224) }
    static var steel: UIColor { return UIColor(red: 96, green: 145, blue: 147) }
    static var orange: UIColor { return UIColor(red: 239, green: 153, blue: 80) }
    static var rust: UIColor { return UIColor(red: 215, green: 156, blue: 140) }
}
