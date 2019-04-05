//
//  DieSide.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

class DieSide {
    var name: String
    var value: Int
    var count: Int
    var points: Int
    var texture: SKTexture
    var counted: Bool = false
    
    init(name: String, value: Int, count: Int, points: Int, texture: SKTexture) {
        self.name = name
        self.value = value
        self.count = count
        self.points = points
        self.texture = texture
    }
}

/*
class dieSide {
    var name: String
    var value: Int
    var count: Int
    var points: Int
    var texture: SKTexture
    
    init(name: String, value: Int, count: Int, points: Int, texture: SKTexture) {
        
        self.name = name
        self.value = value
        self.count = count
        self.points = points
        self.texture = texture
    }
}
*/
