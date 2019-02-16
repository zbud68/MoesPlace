//
//  Player.swift
//  Farkle
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

var player1: Player = Player()
var player2: Player = Player()
var player3: Player = Player()
var player4: Player = Player()

var players: [Player]!

class Player: SKSpriteNode {
    

    let gameScene: GameScene = GameScene()
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
    
    var score: Int = Int(0)
    var scoringDice: [Die] = [die]
    
    var Roll: roll! = roll.init(currentRoll: [], score: 0, diceRemaining: 6, hasScoringDice: false)
    
    var Round: round! = round.init(highScore: 0, score: 0, pointsNeededToWin: 10000, farkle: false, perRoundScores: [], totalNumRounds: 1, finalRound: false)    
    
    var Label: labels! = labels.init()
    
    func checkPlayerState() {
        switch player.playerState {
        case .Idle:
            print("Player State: \(playerState)")
        case .Rolling:
            print("Player State: \(playerState)")
        case .Scored:
            print("Player State: \(playerState)")
        case .Farkle:
            print("Player State: \(playerState)")
        case .FinalRoll:
            print("Player State: \(playerState)")
        case .Won:
            print("Player State: \(playerState)")
        }
    }
}

struct labels {
    var nameLabel: SKLabelNode = SKLabelNode()
    var scoreLabel: SKLabelNode = SKLabelNode()
}

struct roll {
    var currentRoll: [Die] = []
    var score: Int = Int()
    var diceRemaining: Int = Int()
    var hasScoringDice: Bool = Bool(false)
}

struct round {
    var highScore: Int = Int()
    var score: Int = Int()
    var pointsNeededToWin: Int = Int()
    var farkle: Bool = Bool(false)
    var perRoundScores: [Int] = []
    var totalNumRounds: Int = Int()
    var finalRound: Bool = Bool(false)
}


