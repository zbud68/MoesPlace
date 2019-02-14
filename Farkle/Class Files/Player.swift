//
//  Player.swift
//  Farkle
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    enum PlayerState {
        case Idle, Rolling, Scored, Farkle, FinalRoll, Won
    }
    
    var playerState = PlayerState.Idle {
        willSet {
            switch newValue {
            case .Idle:
                print("Idle")
            case .Rolling:
                print("Rolling")
            case .Scored:
                print("Scored")
            case .Farkle:
                print("Farkle")
            case .FinalRoll:
                print("Final Roll")
            case .Won:
                print("Player Won")
            }
        }
    }

    struct playerStats {
        var score: Int
        var currentRoundScore: Int
        var currentRollScore: Int
        var numDiceRemaining: Int
        var pointsNeededToWin: Int
        var finalRoll: Bool
    }
    var stats: playerStats! = playerStats.init(score: 0, currentRoundScore: 0, currentRollScore: 0, numDiceRemaining: 6, pointsNeededToWin: 10000, finalRoll: false)
}
