//
//  GameScene.swift
//  Farkle
//
//  Created by Mark Davis on 1/29/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

//MARK: ********** Global Variables Section **********
var touchLocation = CGPoint(x: 0, y: 0)
var iconWindowTouchLocation = CGPoint(x: 0, y: 0)
var gameTableTouchLocation = CGPoint(x: 0, y: 0)
var id = 0

class GameScene: SKScene, SKPhysicsContactDelegate {
    //MARK: ********** Class Variables Section **********
    let physicsContactDelegate = self
    let worldNode = SKNode()
    
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

    var settingsMenu = SKNode()
    var helpMenu = SKNode()
    
    var GameTable: SKSpriteNode = SKSpriteNode()
    var BackGround: SKSpriteNode = SKSpriteNode()
    var MainMenu: SKSpriteNode = SKSpriteNode()
    var SettingsMenu: SKSpriteNode = SKSpriteNode()
    var HelpMenu: SKSpriteNode = SKSpriteNode()
    var Label: SKLabelNode = SKLabelNode()
    
    var PlayIcon: SKSpriteNode = SKSpriteNode()
    var PauseIcon: SKSpriteNode = SKSpriteNode()
    var ExitIcon: SKSpriteNode = SKSpriteNode()
    var SoundIcon: SKSpriteNode = SKSpriteNode()
    var InfoIcon: SKSpriteNode = SKSpriteNode()
    var MenuIcon: SKSpriteNode = SKSpriteNode()
    var ReloadIcon: SKSpriteNode = SKSpriteNode()
    var SettingsIcon: SKSpriteNode = SKSpriteNode()
    var HomeIcon: SKSpriteNode = SKSpriteNode()
    var BackIcon: SKSpriteNode = SKSpriteNode()
    var iconTouched: String = String("")
    
    var IconWindow: SKSpriteNode = SKSpriteNode()
    var ScoresWindow: SKSpriteNode = SKSpriteNode()
    
    var Icons = [SKSpriteNode]()
    var IconWindowIcons = [SKSpriteNode]()
    var Dice = [SKSpriteNode]()

    var Die1: SKSpriteNode = SKSpriteNode()
    var Die2: SKSpriteNode = SKSpriteNode()
    var Die3: SKSpriteNode = SKSpriteNode()
    var Die4: SKSpriteNode = SKSpriteNode()
    var Die5: SKSpriteNode = SKSpriteNode()
    var Die6: SKSpriteNode = SKSpriteNode()
    
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
    
    var diceAction: SKAction = SKAction()

    //MARK: ********** didMove Section **********
    override func didMove(to view: SKView) {
        
        self.physicsWorld.gravity = CGVector(dx: -6.0, dy: 0)

        selfMaxX = self.frame.maxX
        selfMaxY = self.frame.maxY
        selfMinX = self.frame.minX
        selfMinY = self.frame.minY
        selfWidth = self.size.width
        selfHeight = self.size.height

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
    
    //MARK: ********** Game Flow Section **********
    func startNewGame() {
        gameState = .InProgress
        
        setupBackGround()
        setupGameTable()
        setupIconWindow()
        setupScoresWindow()
        setupIcons()
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

    //MARK: ********** Touches Section **********
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchLocation = touch.location(in: self)
            iconWindowTouchLocation = touch.location(in: IconWindow)
            gameTableTouchLocation = touch.location(in: GameTable)
        }
        wasIconTouched()
    }
    
    func wasIconTouched() {
        for icon in IconWindowIcons {
            if icon.contains(iconWindowTouchLocation) {
                switch icon.name {
                case "Play Icon":
                    playIconTouched()
                case "Pause Icon":
                    print("pause icon touched")
                case "Reload Icon":
                    reloadIconTouched()
                case "Menu Icon":
                    print("menu icon touched")
                case "Exit Icon":
                    print("sound icon touched")
                default:
                    break
                }
            }
        }
    }
    
    func iconWasTouched(icon: String) {
        //let Icon = icon
    }
    
    func playIconTouched() {
        rollDice()
    }
    
    func reloadIconTouched() {
        positionDice()
    }
    
    //MARK: ********** Check State Machines **********
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

    //MARK: ********** Updates Section **********
    override func update(_ currentTime: TimeInterval) {
    
    }
}
