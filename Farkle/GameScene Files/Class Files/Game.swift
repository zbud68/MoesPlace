//
//  Game.swift
//  Farkle
//
//  Created by Mark Davis on 2/14/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

class Game {
    var numDice = 5
    var numPlayers = 2
    var targetScore = 10000
    var matchTargetScore = true
    var numRounds = 1
    
    let defaults: Defaults = Defaults()
}

struct Defaults {
    let numDice: Int = Int(5)
    let numPlayers: Int = Int(2)
    let targetScore: Int = Int(10000)
    let matchTargetScore: Bool = Bool(true)
}

