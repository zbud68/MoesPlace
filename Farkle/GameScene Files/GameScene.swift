//
//  GameScene.swift
//  Farkle
//
//  Created by Mark Davis on 1/29/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

// MARK: ********** Global Variables Section **********

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
                    break
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
                print("new game")
                startNewGame()
                gameState = .InProgress
            case .InProgress:
                print("in progress")
                continueRound()
            case .NewRound:
                print("new round")
                startNewRound()
                gameState = .InProgress
            case .GameOver:
                print("game over")
                endGame()
        }
    }

    // MARK: ********** Game Flow Section **********

    func startNewGame() {
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

    func wasIconTouched() {
        for icon in iconWindowIcons {
            if icon.contains(iconWindowTouchLocation) {
                switch icon.name {
                    case "Play Icon":
                        playIconTouched()
                    case "Pause Icon":
                        pauseIconTouched()
                    case "Reload Icon":
                        reloadIconTouched()
                    case "Menu Icon":
                        menuIconTouched()
                    case "Settings Icon":
                        settingsIconTouched()
                    default:
                        break
                }
            }
        }
    }
    func wasDiceTouched() {
        for dieNode in dice {
            if dieNode.contains(gameTableTouchLocation) {
                if dieNode.selected == false {
                    switch dieNode.faceValue {
                        case 1:
                            dieNode.texture = SKTexture(imageNamed: "Selectable_Die1")
                        case 2:
                            dieNode.texture = SKTexture(imageNamed: "Selectable_Die2")
                        case 3:
                            dieNode.texture = SKTexture(imageNamed: "Selectable_Die3")
                        case 4:
                            dieNode.texture = SKTexture(imageNamed: "Selectable_Die4")
                        case 5:
                            dieNode.texture = SKTexture(imageNamed: "Selectable_Die5")
                        case 6:
                            dieNode.texture = SKTexture(imageNamed: "Selectable_Die6")
                        default:
                            break
                    }
                    dieNode.selected = true
                } else {
                    switch dieNode.faceValue {
                        case 1:
                            dieNode.texture = SKTexture(imageNamed: "Die1")
                        case 2:
                            dieNode.texture = SKTexture(imageNamed: "Die2")
                        case 3:
                            dieNode.texture = SKTexture(imageNamed: "Die3")
                        case 4:
                            dieNode.texture = SKTexture(imageNamed: "Die4")
                        case 5:
                            dieNode.texture = SKTexture(imageNamed: "Die5")
                        case 6:
                            dieNode.texture = SKTexture(imageNamed: "Die6")
                        default:
                            break
                    }
                    dieNode.selected = false
                }
            }
        }
    }

    func playIconTouched() {
        rollDice()
        playerState = .Idle
    }

    func pauseIconTouched() {
        print("Pause Icon was Touched")
        //worldNode.isPaused = true
    }
    
    func reloadIconTouched() {
        removeAllActions()
        positionDice()
    }
    
    func menuIconTouched() {
        print("Menu Icon was Touched")
    }
    
    func settingsIconTouched() {
        print("Settings Icon was Touched")
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
        switch playerState {
            case .Idle:
                print("Player State: \(playerState)")
            case .Rolling:
                print("Player State: \(playerState)")
            case .Scored:
                print("Player State: \(playerState)")
            case .LostTurn:
                print("Player State: \(playerState)")
            case .FinalRoll:
                print("Player State: \(playerState)")
            case .Won:
                print("Player State: \(playerState)")
        }
    }

    // MARK: ********** Updates Section **********

    override func update(_ currentTime: TimeInterval) {
        if playerState == .Rolling {
            // updateDieFrames()
        }
    }
}
