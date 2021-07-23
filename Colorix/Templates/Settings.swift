//
//  Settings.swift
//  Colorix
//
//  Created by Kejvi Peti on 2021-07-22.
//

import SpriteKit

enum PhysicsCategories {
    static let none: UInt32 = 0
    static let ballCategory: UInt32 = 0x1               //01
    static let switchCategory: UInt32 = 0x1 << 1        //10
}

enum ZPositions {
    static let label: CGFloat = 0
    static let ball : CGFloat = 1
    static let colorSwitch : CGFloat = 2
}

struct Colors {
    static let space_cadet = UIColor(red: 21/255, green: 30/255, blue: 63/255, alpha: 1.0)
    static let beige = UIColor(red: 242/255, green: 243/255, blue: 217/255, alpha: 1.0)
    
    static let levelColor = [
        UIColor(red: 0.68/2.55, green: 0.64/2.55, blue: 0.69/2.55, alpha: 1.00),
        UIColor(red: 0.78/2.55, green: 0.82/2.55, blue: 0.93/2.55, alpha: 1.00),
        UIColor(red: 0.39/2.55, green: 0.33/2.55, blue: 0.50/2.55, alpha: 1.00),
        UIColor(red: 0.56/2.55, green: 0.44/2.55, blue: 0.55/2.55, alpha: 1.00)
    ]
}
