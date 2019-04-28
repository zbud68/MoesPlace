//
//  DieSide.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

struct DieSide {
    
    var name: String
    var value: Int
    var count: Int
    var points: Int

    init(name: String, value: Int, count: Int, points: Int) {
        self.name = name
        self.value = value
        self.count = count
        self.points = points
    }
}
