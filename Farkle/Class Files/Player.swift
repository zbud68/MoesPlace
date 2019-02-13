//
//  Player.swift
//  Farkle
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

enum PlayerState {
    case Idle, Rolling, Scored, LostTurn, FinalRoll, Won
}

var playerState = PlayerState.Idle {
    willSet {
        switch newValue {
            case .Idle:
                print("Idle")
            case .Rolling:
                print("Rolling")
            case .Scored:
                print("Has Scored")
            case .LostTurn:
                print("Lost turn")
            case .FinalRoll:
                print("Final Roll")
            case .Won:
                print("Player Won")
        }
    }
}

class Player: SKSpriteNode {
    struct playerStats {
        var score: Int
        var currentRoundScore: Int
        var numDiceRemaining: Int
        var pointsNeededToWin: Int
        var finalRoll: Bool
    }
    var stats: playerStats! = playerStats.init(score: 0, currentRoundScore: 0, numDiceRemaining: 6, pointsNeededToWin: 10000, finalRoll: false)
}
