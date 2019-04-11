//
//  GameScene.swift
//  Moe's Place
//
//  Created by Mark Davis on 1/29/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit
import UIKit

let gameVC: GameViewController = GameViewController()

// MARK: ********** Global Variables Section **********
enum GameState {
    case NewGame, InProgress, NewRound, GameOver
}

let handlerBlock: (Bool) -> Void = {
    if $0 {
        return
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    // MARK: ********** Class Variables Section **********
    let physicsContactDelegate = self

    //MARK: ********** Game Variables **********
    var gameState = GameState.NewGame {
        willSet {
            switch newValue {
                case .NewGame:
                    setupNewGame()
                case .InProgress:
                    print("game in progress")
                case .NewRound:
                    startNewRound()
                case .GameOver:
                    exit(0)
            }
        }
    }
    
    var currentGame: Game = Game()
    
    //MARK: ********** Player Variables **********
    let player1 = Player(score: 0, currentRollScore: 0, hasScoringDice: false)
    let player2 = Player(score: 0, currentRollScore: 0, hasScoringDice: false)
    let player3 = Player(score: 0, currentRollScore: 0, hasScoringDice: false)
    let player4 = Player(score: 0, currentRollScore: 0, hasScoringDice: false)
    
    var currentPlayer: Player!
    var currentPlayerID: Int = 0
    var playersArray: [Player]!
    let playerNameLabel: SKLabelNode = SKLabelNode()
    
    //MARK: ********** Dice Variables **********
    var die1: Die = Die()
    var die2: Die = Die()
    var die3: Die = Die()
    var die4: Die = Die()
    var die5: Die = Die()
    var die6: Die = Die()
    
    var diceArray: [Die] = [Die]()
    var currentDiceArray: [Die] = [Die]()
    var diePositionsArray: [CGPoint] = [CGPoint]()
    var positionsArray: [CGPoint] = [CGPoint]()
    var scoringDiceArray: [Die] = [Die]()
    //var positionID: Int = Int(0)
    
    var diePosition1: CGPoint = CGPoint()
    var diePosition2: CGPoint = CGPoint()
    var diePosition3: CGPoint = CGPoint()
    var diePosition4: CGPoint = CGPoint()
    var diePosition5: CGPoint = CGPoint()
    var diePosition6: CGPoint = CGPoint()
    
    var reducedPositionArray: [CGPoint] = [CGPoint]()
        
    //MARK: ********** DieFace Variables **********
    var dieSide1: DieSide = DieSide(name: "Die 1", value: 1, count: 0, points: 10, texture: GameConstants.Textures.Die1)
    var dieSide2: DieSide = DieSide(name: "Die 2", value: 2, count: 0, points: 2, texture: GameConstants.Textures.Die2)
    var dieSide3: DieSide = DieSide(name: "Die 3", value: 3, count: 0, points: 3, texture: GameConstants.Textures.Die3)
    var dieSide4: DieSide = DieSide(name: "Die 4", value: 4, count: 0, points: 4, texture: GameConstants.Textures.Die4)
    var dieSide5: DieSide = DieSide(name: "Die 5", value: 5, count: 0, points: 5, texture: GameConstants.Textures.Die5)
    var dieSide6: DieSide = DieSide(name: "Die 6", value: 6, count: 0, points: 6, texture: GameConstants.Textures.Die6)
    
    var dieSidesArray: [DieSide] = [DieSide]()
    var currentRollArray: [DieSide] = [DieSide]()
    var currentDieValuesArray: [Int] = [Int]()

    //MARK: ********** Scoring Variables **********
    let lowStraight: [Int] = [1,2,3,4,5]
    let highStraight: [Int] = [2,3,4,5,6]
    let sixDieStraight: [Int] = [1,2,3,4,5,6]
    
    var straight = false
    var fullHouse = false
    var threePair = false
    var threeOAK: Bool = false
    var fourOAK: Bool = false
    var fiveOAK: Bool = false
    var sixOAK: Bool = false
    var pairs = 0
    
    var currentScore: Int = 0
    let currentScoreLabel: SKLabelNode = SKLabelNode()
    
    //MARK: ********** User Interface Variables **********
    let logo = SKLabelNode(text: "Farkle")
    let logo2 = SKLabelNode(text: "Plus")
    var mainMenuHolder: SKNode = SKNode()
    var settingsMenuHolder: SKNode = SKNode()
    var iconWindowIconsHolder: SKNode = SKNode()
    var gameTableHolder: SKNode = SKNode()
    var gameTable: SKSpriteNode = SKSpriteNode()
    var backGround: SKSpriteNode = SKSpriteNode()
    var mainMenu: SKSpriteNode = SKSpriteNode()
    var settingsMenu: SKSpriteNode = SKSpriteNode()
    var helpMenu: SKSpriteNode = SKSpriteNode()
    var mainMenuLabel: SKLabelNode = SKLabelNode()
    var settingsMenuLabel: SKLabelNode = SKLabelNode()
    var soundIconLabel: SKLabelNode = SKLabelNode()
    var backIconLabel: SKLabelNode = SKLabelNode()
    var newGameIconLabel: SKLabelNode = SKLabelNode()
    var settingsIconLabel: SKLabelNode = SKLabelNode()
    var resumeIconLabel: SKLabelNode = SKLabelNode()
    var exitIconLabel: SKLabelNode = SKLabelNode()
    var rollDiceIconLabel: SKLabelNode = SKLabelNode()
    var keepScoreIconLabel: SKLabelNode = SKLabelNode()

    var newGameIcon: SKSpriteNode = SKSpriteNode()
    var pauseIcon: SKSpriteNode = SKSpriteNode()
    var exitIcon: SKSpriteNode = SKSpriteNode()
    var soundIcon: SKSpriteNode = SKSpriteNode()
    var infoIcon: SKSpriteNode = SKSpriteNode()
    var menuIcon: SKSpriteNode = SKSpriteNode()
    var resumeIcon: SKSpriteNode = SKSpriteNode()
    var settingsIcon: SKSpriteNode = SKSpriteNode()
    var homeIcon: SKSpriteNode = SKSpriteNode()
    var backIcon: SKSpriteNode = SKSpriteNode()
    var iconTouched: String = String("")
    var rollDiceIcon: SKSpriteNode = SKSpriteNode()
    var keepScoreIcon: SKSpriteNode = SKSpriteNode()
    
    var iconWindow: SKSpriteNode = SKSpriteNode()
    var scoresWindow: SKSpriteNode = SKSpriteNode()
    
    var mainMenuIconsArray = [SKSpriteNode]()
    var settingsMenuIconsArray = [SKSpriteNode]()
    var iconWindowIconsArray = [SKSpriteNode]()
    
    //MARK: ********** Touches Variables **********
    var touchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var currentTouch: UITouch = UITouch()
    var currentTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var iconWindowTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var gameTableTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var mainMenuTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var settingsMenuTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    
    var threeOAKValue = 0
    var fourOAKValue = 0
    var fiveOAKValue = 0
    var sixOAKValue = 0

    // MARK: ********** didMove Section **********
    override func didMove(to view: SKView) {
        setupBackGround()
        setupGameTable()
        setupLogo()
        setupIconWindow()
        setupScoresWindow()
        displayMainMenu()
        displaySettingsMenu()
        setupPlayers()
        setupCurrentRollScoreLabel()
    }
    
    func displayMainMenu() {
        mainMenu.texture = GameConstants.Textures.MainMenu
        mainMenu.name = "MainMenu"
        mainMenu.position = CGPoint(x: 0, y: 0)
        mainMenu.size = CGSize(width: frame.size.width / 2, height: frame.size.height / 1.5)
        mainMenu.zPosition = GameConstants.ZPositions.Menu
        if gameState == .NewGame {
            setupMainMenuIcons()
        }
    }
    
    func displaySettingsMenu() {
        settingsMenu.texture = GameConstants.Textures.SettingsMenu
        settingsMenu.name = "SettingsMenu"
        settingsMenu.position = CGPoint(x: 0, y: 0)
        settingsMenu.size = CGSize(width: frame.size.width / 2, height: frame.size.height / 1.5)
        settingsMenu.zPosition = GameConstants.ZPositions.Menu
        setupSettingsMenuIcons()
    }

    // MARK: ********** Touches Section **********
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            iconWindowTouchLocation = touch.location(in: iconWindow)
            gameTableTouchLocation = touch.location(in: gameTable)
            mainMenuTouchLocation = touch.location(in: mainMenu)
            settingsMenuTouchLocation = touch.location(in: settingsMenu)
        }
        wasMainMenuIconTouched()
        wasSettingsMenuIconTouched()
        wasIconWindowIconTouched()
        wasDiceTouched()
    }
    
    func wasMainMenuIconTouched() {
        for icon in mainMenuIconsArray where icon.contains(mainMenuTouchLocation) {
            switch icon.name {
            case "New Game":
                newGameIconTouched()
            case "Continue":
                resumeIconTouched()
            case "Settings":
                settingsIconTouched()
            case "Exit":
                exitIconTouched()
            case "Info":
                infoIconTouched()
            default:
                break
            }
        }
    }
    
    func wasSettingsMenuIconTouched() {
        for icon in settingsMenuIconsArray where icon.contains(settingsMenuTouchLocation) {
            switch icon.name {
            case "Sound":
                soundIconTouched()
            case "Back":
                backIconTouched()
            default:
                break
            }
        }
    }
    
    func wasIconWindowIconTouched() {
        for icon in iconWindowIconsArray where icon.contains(iconWindowTouchLocation) {
            switch icon.name {
            case "Pause":
                pauseIconTouched()
            case "RollDice":
                rollDice()
            case "KeepScore":
                keepScoreIconTouched()
            default:
                break
            }
        }
    }
    
    func wasDiceTouched() {
        for die in scoringDiceArray {
            if die.contains(gameTableTouchLocation) {
                die.physicsBody?.categoryBitMask = 100
                die.physicsBody?.isDynamic = false
                die.selectable = false
                die.selected = true
                die.zRotation = 0
                if diePositionsArray.isEmpty {
                    diePositionsArray = positionsArray
                } else {
                    die.position = diePositionsArray.first!
                    diePositionsArray.removeFirst()
                }
            }
        }
    }

    func newGameIconTouched() {
        if gameState == .InProgress {
            gameInProgressMessage(on: scene!, title: "Game In Progress", message: GameConstants.Messages.GameInProgress)
        } else {
            showIconWindowIcons()
            setupNewGame()
        }
    }
    
    func setupNewGame() {
        setupDice()
        gameState = .InProgress
        currentGame = Game()
        currentPlayerID = 0
    }
    
    func resumeIconTouched() {
        if gameState == .NewGame {
            noGameInProgessMessage(on: scene!, title: "No Game In Progess", message: GameConstants.Messages.NoGameInProgress)
        } else {
            showIconWindowIcons()
        }
    }
    
    func settingsIconTouched() {
        if gameState == .InProgress {
            print("game in progress")
        } else {
            print("settings icon touched")
            showSettingsMenu()
        }
    }
    
    func exitIconTouched() {
        if gameState == .InProgress {
            print("game in progress")
            gameInProgressMessage(on: scene!, title: "Game in Progress", message: GameConstants.Messages.GameInProgress)
        } else {
            gameOverMessage(on: scene!, title: "Game Over", message: GameConstants.Messages.GameOver)
            exit(0)
        }
    }
    
    func infoIconTouched() {
        print("Info Icon was Touched")
    }
    
    func soundIconTouched() {
        print("sound icon touched")
    }
    
    func backIconTouched() {
        print("back icon touched")
        showMainMenu()
    }
    
    func pauseIconTouched() {
        if pauseIcon.isPaused != true {
            //gameVC.showMessage(on: scene!, title: "Game Paused", message: "Game Paused, Press OK to Continue")
            showMainMenu()
        }
    }
    
    func keepScoreIconTouched() {
        print("keep score icon touched")
        currentPlayer.score += currentPlayer.currentRollScore
        currentPlayer.scoreLabel.text = String(currentPlayer.score)
        nextPlayer()
    }
    
    func nextPlayer() {
        diePositionsArray.removeAll()
        currentDiceArray.removeAll()
        currentDiceArray = diceArray
        returnDiceToHomePosition()

        for die in currentDiceArray {
            die.physicsBody?.allowsRotation = true
        }
        if currentPlayerID < playersArray.count - 1 {
            currentPlayerID += 1
        } else {
            currentPlayerID = 0
        }
        currentPlayer = playersArray[currentPlayerID]
        currentPlayer.firstRoll = true
        resetCurrentScoreVariables()
        resetCounters()
        resetArrays()
        playerNameLabel.text = "\(currentPlayer.name):"
    }
    
    func startNewRoll() {
        diePositionsArray.removeAll()
        diePositionsArray = positionsArray
        currentDiceArray = diceArray
        currentPlayer.firstRoll = true
        rollDice()
    }
    
    func startNewRound() {
        diePositionsArray.removeAll()
        currentDiceArray.removeAll()
        currentDiceArray = diceArray
        currentPlayerID = 0
        for player in playersArray {
            player.currentRollScore = 0
            player.firstRoll = true
        }
        resetDice()
        currentGame.numRounds += 1
    }
    
    func showMainMenu() {
        hideSettingMenu()
        hideIconWindowIcons()
        addMainMenu()
     }
    
    func hideMainMenu() {
        newGameIcon.removeAllChildren()
        resumeIcon.removeAllChildren()
        settingsIcon.removeAllChildren()
        exitIcon.removeAllChildren()
        infoIcon.removeAllChildren()
        mainMenu.removeAllChildren()
        mainMenu.removeFromParent()
    }
    
    func showSettingsMenu() {
        hideMainMenu()
        hideIconWindowIcons()
        addSettingsMenu()
    }
    
    func hideSettingMenu() {
        soundIcon.removeAllChildren()
        backIcon.removeAllChildren()
        settingsMenu.removeAllChildren()
        settingsMenu.removeFromParent()
    }
    
    func showIconWindowIcons() {
        hideMainMenu()
        hideSettingMenu()
        addIconWindowIcons()
        for icon in iconWindowIconsArray {
            icon.isPaused = false
        }
    }
    
    func hideIconWindowIcons() {
        iconWindow.removeAllChildren()
        for icon in iconWindowIconsArray {
            icon.isPaused = true
        }
    }
    
    func resetCurrentScoreVariables() {
        currentPlayer.currentRollScore = 0
        currentScore = 0
        currentScoreLabel.text = String(0)
    }
    
    func resetPlayerScoreVariables() {
        for player in playersArray {
            player.score = 0
            player.scoreLabel.text = String(0)
            player.hasScoringDice = false
        }
        currentPlayer.firstRoll = true
    }
    
    func resetArrays() {
        currentDieValuesArray.removeAll()
        currentDiceArray = diceArray
    }
    
    func resetDice() {
        for die in currentDiceArray {
            die.dieSide!.count = 0
            die.dieSide!.counted = false
            die.selected = false
            die.selectable = true

            die.zRotation = 0
            die.physicsBody?.allowsRotation = true
            die.zPosition = GameConstants.ZPositions.Dice
            die.size = GameConstants.Sizes.Dice
            
            die.physicsBody?.isDynamic = true
            die.physicsBody?.categoryBitMask = 1
            die.physicsBody?.contactTestBitMask = 1
            die.physicsBody?.collisionBitMask = 1
        }
        
        for dieSide in dieSidesArray {
            dieSide.count = 0
            dieSide.counted = false
        }
    }
    
    func showScoreTotal() {
        currentPlayer.score += currentPlayer.currentRollScore
        print("current roll score: \(currentPlayer.currentRollScore)")
        currentPlayer.currentRollScore = 0
        print("current Score: \(currentPlayer.score)")
    }
    
    /*
    func showMessage(msg: String) {
        print("player farkled")
    }
    */
    
    // MARK: ********** Updates Section **********
    
    override func update(_ currentTime: TimeInterval) {
        currentScoreLabel.text = String(currentPlayer.currentRollScore)
    }
}
