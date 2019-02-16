//
//  Die.swift
//  Farkle
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

class Die: SKSpriteNode {
    var faceValue: Int = Int()
    var rollResults: [Int] = []
    var selected: Bool = false
    var scoringDie: Bool = false
    var scoringCombination: Bool = false
}
