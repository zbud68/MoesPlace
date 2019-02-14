//
//  GameScene.swift
//  Farkle
//
//  Created by Mark Davis on 1/29/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

// MARK: ********** Global Variables Section **********

var playerState = player.playerState

var id: Int = 0

var player: Player = Player()
var die: Die = Die()

var dice: [Die] = [die]

var die1: Die = die
var die2: Die = die
var die3: Die = die
var die4: Die = die
var die5: Die = die
var die6: Die = die

var rollAction = SKAction()

let logo = SKLabelNode(text: "Farkle")
let logo2 = SKLabelNode(text: "Plus")

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var numDice = 6
    var numPlayers = 1
    var targetScore = 10000
    var matchTargetScore = true
    
    var touchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var iconWindowTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var gameTableTouchLocation: CGPoint = CGPoint(x: 0, y: 0)

    var gameTable: SKSpriteNode = SKSpriteNode()
    var backGround: SKSpriteNode = SKSpriteNode()
    var mainMenu: SKSpriteNode = SKSpriteNode()
    var settingsMenu: SKSpriteNode = SKSpriteNode()
    var helpMenu: SKSpriteNode = SKSpriteNode()
    var label: SKLabelNode = SKLabelNode()

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
    
    // MARK: ********** Class Variables Section **********

    let physicsContactDelegate = self
    let worldNode: SKNode = SKNode()

    enum GameState {
        case NewGame, InProgress, NewRound, GameOver
    }

    var gameState = GameState.NewGame {
        willSet {
            switch newValue {
                case .NewGame:
                    startNewGame()
                case .InProgress:
                    break
                case .NewRound:
                    startNewRound()
                case .GameOver:
                    break
            }
        }
    }

    // MARK: ********** didMove Section **********
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: -6.0, dy: 0)

        selfMaxX = frame.maxX
        selfMaxY = frame.maxY
        selfMinX = frame.minX
        selfMinY = frame.minY
        selfWidth = size.width
        selfHeight = size.height

        addChild(worldNode)
        switch gameState {
            case .NewGame:
                startNewGame()
                gameState = .InProgress
            case .InProgress:
                continueRound()
            case .NewRound:
                startNewRound()
            case .GameOver:
                endGame()
        }
    }

    // MARK: ********** Game Flow Section **********

    func startNewGame() {
        print("New Game")
        gameState = .InProgress

        setupBackGround()
        setupGameTable()
        setupLabel()
        setupIconWindow()
        setupScoresWindow()
        setupIcons()
        setupPlayers()
        setupDice()
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


    // MARK: ********** Check State Machines **********

    func checkGameState() {
        switch gameState {
            case .NewGame:
                print("Game State \(gameState)")
            case .NewRound:
                print("Game State \(gameState)")
            case .InProgress:
                print("Game State \(gameState)")
            case .GameOver:
                print("Game State \(gameState)")
        }
    }

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

    // MARK: ********** Updates Section **********

    override func update(_ currentTime: TimeInterval) {

    }
}
