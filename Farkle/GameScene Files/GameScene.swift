//
//  GameScene.swift
//  Farkle
//
//  Created by Mark Davis on 1/29/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

// MARK: ********** Global Variables Section **********

var die1: Die!
var die2: Die!
var die3: Die!
var die4: Die!
var die5: Die!
var die6: Die!

var dice: [Die]!

var playerState = player.playerState

var id: Int = 0

var player: Player = Player()
var die: Die = Die()
var game: Game = Game()

var currentGame: Game = game

var rollAction = SKAction()

let logo = SKLabelNode(text: "Farkle")
let logo2 = SKLabelNode(text: "Plus")

let LabelColor = UIColor(red: 161, green: 0, blue: 0, alpha: 100)

var gameTable: SKSpriteNode = SKSpriteNode()
var backGround: SKSpriteNode = SKSpriteNode()
var mainMenu: SKSpriteNode = SKSpriteNode()
var settingsMenu: SKSpriteNode = SKSpriteNode()
var helpMenu: SKSpriteNode = SKSpriteNode()
var label: SKLabelNode = SKLabelNode()

enum GameState {
    case NewGame, InProgress, NewRoll, NewRound, GameOver
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameState = GameState.NewGame {
        willSet {
            switch newValue {
            //case .NewGame:
                //setupNewGame()
            case .InProgress:
                break
            case .NewRoll:
                break
            //case .NewRound:
                //startNewRound()
            case .GameOver:
                break
            default:
                break
            }
        }
    }
    
    /*
    var player1NameLabel: SKLabelNode = SKLabelNode()
    var player1ScoreLabel: SKLabelNode = SKLabelNode()
    var player2NameLabel: SKLabelNode = SKLabelNode()
    var player2ScoreLabel: SKLabelNode = SKLabelNode()
    var player3NameLabel: SKLabelNode = SKLabelNode()
    var player3ScoreLabel: SKLabelNode = SKLabelNode()
    var player4NameLabel: SKLabelNode = SKLabelNode()
    var player4ScoreLabel: SKLabelNode = SKLabelNode()
    */

    var touchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var iconWindowTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var gameTableTouchLocation: CGPoint = CGPoint(x: 0, y: 0)

    var playIcon: SKSpriteNode = SKSpriteNode()
    var pauseIcon: SKSpriteNode = SKSpriteNode()
    var exitIcon: SKSpriteNode = SKSpriteNode()
    var soundIcon: SKSpriteNode = SKSpriteNode()
    var infoIcon: SKSpriteNode = SKSpriteNode()
    var menuIcon: SKSpriteNode = SKSpriteNode()
    var reloadIcon: SKSpriteNode = SKSpriteNode()
    var settingsIcon: SKSpriteNode = SKSpriteNode()
    var homeIcon: SKSpriteNode = SKSpriteNode()
    var backIcon: SKSpriteNode = SKSpriteNode()
    var iconTouched: String = String("")

    var iconWindow: SKSpriteNode = SKSpriteNode()
    var scoresWindow: SKSpriteNode = SKSpriteNode()

    var icons = [SKSpriteNode]()
    var iconWindowIcons = [SKSpriteNode]()
    
    var selfMaxX: CGFloat = CGFloat(0)
    var selfMinX: CGFloat = CGFloat(0)
    var selfMaxY: CGFloat = CGFloat(0)
    var selfMinY: CGFloat = CGFloat(0)
    var selfWidth: CGFloat = CGFloat(0)
    var selfHeight: CGFloat = CGFloat(0)

    var backGroundMaxX: CGFloat = CGFloat(0)
    var backGroundMinX: CGFloat = CGFloat(0)
    var backGroundMaxY: CGFloat = CGFloat(0)
    var backGroundMinY: CGFloat = CGFloat(0)
    var backGroundWidth: CGFloat = CGFloat(0)
    var backGroundHeight: CGFloat = CGFloat(0)

    var gameTableMaxX: CGFloat = CGFloat(0)
    var gameTableMinX: CGFloat = CGFloat(0)
    var gameTableMaxY: CGFloat = CGFloat(0)
    var gameTableMinY: CGFloat = CGFloat(0)
    var gameTableWidth: CGFloat = CGFloat(0)
    var gameTableHeight: CGFloat = CGFloat(0)

    var iconWindowMaxX: CGFloat = CGFloat(0)
    var iconWindowMinX: CGFloat = CGFloat(0)
    var iconWindowMaxY: CGFloat = CGFloat(0)
    var iconWindowMinY: CGFloat = CGFloat(0)
    var iconWindowWidth: CGFloat = CGFloat(0)
    var iconWindowHeight: CGFloat = CGFloat(0)

    var iconWidth: CGFloat = CGFloat(0)
    var iconHeight: CGFloat = CGFloat(0)

    var scoresWindowMaxX: CGFloat = CGFloat(0)
    var scoresWindowMinX: CGFloat = CGFloat(0)
    var scoresWindowMaxY: CGFloat = CGFloat(0)
    var scoresWindowMinY: CGFloat = CGFloat(0)
    var scoresWindowWidth: CGFloat = CGFloat(0)
    var scoresWindowHeight: CGFloat = CGFloat(0)
    
    var currentRoundScore = 0
    var roundScore = 0
    
    // MARK: ********** Class Variables Section **********

    let physicsContactDelegate = self

    // MARK: ********** didMove Section **********
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: -6.0, dy: 0)

        setupNewGame()
    }

    // MARK: ********** Touches Section **********

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchLocation = touch.location(in: self)
            iconWindowTouchLocation = touch.location(in: iconWindow)
            gameTableTouchLocation = touch.location(in: gameTable)
        }
        wasIconTouched()
        wasDiceTouched()
    }
    
    func setupNewGame() {
        getGameSettings()
        setupGameScene()
        setupPlayers()
        setupDice()
    }
    
    func setupGameScene() {
        setupBackGround()
        setupGameTable()
        setupLogo()
        setupIconWindow()
        setupScoresWindow()
        setupIcons()
    }
    
    func getGameSettings() {
        if game.settingsChanged == true {
            currentGame.numDice = game.numDice
            currentGame.numPlayers = game.numPlayers
            currentGame.targetScore = game.targetScore
            currentGame.matchTargetScore = game.matchTargetScore
        } else {
            currentGame.numDice = GameConstants.GameDefaults.dice
            currentGame.numPlayers = GameConstants.GameDefaults.players
            currentGame.targetScore = GameConstants.GameDefaults.targetScore
            currentGame.matchTargetScore = GameConstants.GameDefaults.matchTarget
        }
    }
    
    func continueRound() {
        print("continue round")
    }
    
    func startNewRound() {
        print("start new round")
    }
    
    func endGame() {
        print("end game")
    }
    
    func checkGameState() {
        switch gameState {
        case .NewGame:
            //setupNewGame()
            gameState = .InProgress
        case .InProgress:
            print("Game State \(gameState)")
        case .NewRoll:
            print("New Roll")
        case .NewRound:
            //startNewRound()
            gameState = .NewRound
        //case .GameOver:
            //endGame()
        default:
            break
        }
    }

    // MARK: ********** Updates Section **********

    override func update(_ currentTime: TimeInterval) {

    }
}
