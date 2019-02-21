//
//  Player.swift
//  Farkle
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

class Player {
    let nameLabel: SKLabelNode = SKLabelNode()
    var name: String = ""

    var score: Int
    let scoreLabel: SKLabelNode = SKLabelNode()
    var hasScoringDice: Bool
    
    init(score: Int, hasScoringDice: Bool)
    {
        self.score = score
        self.hasScoringDice = hasScoringDice
    }
}

