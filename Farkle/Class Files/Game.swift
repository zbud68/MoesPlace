//
//  Game.swift
//  Farkle
//
//  Created by Mark Davis on 2/14/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

class Game: SKSpriteNode {
    var numDice = 6
    var numPlayers = 4
    var targetScore = 10000
    var matchTargetScore = true
    var settingsChanged = false
    
    func hasSettingsChanged() -> Bool {
        if numDice != GameConstants.GameDefaults.dice && numPlayers != GameConstants.GameDefaults.players && targetScore != GameConstants.GameDefaults.targetScore && matchTargetScore != GameConstants.GameDefaults.matchTarget {
            
            settingsChanged = true
        }
        return settingsChanged
    }
}

