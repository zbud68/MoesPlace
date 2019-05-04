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
enum DieSides {
    case One(Int)
    case Two(Int)
    case Three(Int)
    case Four(Int)
    case Five(Int)
    case Sixe(Int)
}

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

    // MARK: ********** Game Variables **********

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

    // MARK: ********** Player Variables **********

    var player1 = Player(name: "Player1", score: 0, currentRollScore: 0, hasScoringDice: false)
    var player2 = Player(name: "Player2", score: 0, currentRollScore: 0, hasScoringDice: false)
    var player3 = Player(name: "Player3", score: 0, currentRollScore: 0, hasScoringDice: false)
    var player4 = Player(name: "Player4", score: 0, currentRollScore: 0, hasScoringDice: false)

    var currentPlayer: Player!
    var currentPlayerID: Int = 0
    var playersArray: [Player]!
    var playerNameLabel: SKLabelNode = SKLabelNode()

    // MARK: ********** Dice Variables **********

    var die1: Die = Die()
    var die2: Die = Die()
    var die3: Die = Die()
    var die4: Die = Die()
    var die5: Die = Die()
    var die6: Die = Die()

    var diceArray: [Die] = [Die]()
    var currentDiceArray: [Die] = [Die]()
    var scoringDiceArray: [Die] = [Die]()

    var die1PlaceHolder = SKSpriteNode()
    var die2PlaceHolder = SKSpriteNode()
    var die3PlaceHolder = SKSpriteNode()
    var die4PlaceHolder = SKSpriteNode()
    var die5PlaceHolder = SKSpriteNode()
    var die6PlaceHolder = SKSpriteNode()

    var diePosition1: CGPoint = CGPoint()
    var diePosition2: CGPoint = CGPoint()
    var diePosition3: CGPoint = CGPoint()
    var diePosition4: CGPoint = CGPoint()
    var diePosition5: CGPoint = CGPoint()
    var diePosition6: CGPoint = CGPoint()

    // MARK: ********** DieFace Variables **********

    var dieFace1: DieFace = DieFace(faceValue: 1)
    var dieFace2: DieFace = DieFace(faceValue: 2)
    var dieFace3: DieFace = DieFace(faceValue: 3)
    var dieFace4: DieFace = DieFace(faceValue: 4)
    var dieFace5: DieFace = DieFace(faceValue: 5)
    var dieFace6: DieFace = DieFace(faceValue: 6)
    var dieFacesArray: [Int] = [Int]()

    var currentDieValuesArray: [Int] = [Int]()
    var selectedDieArray: [Die] = [Die]()
    var dieFaceValue = Int()
    var dieFaceCount = Int()

    // MARK: ********** Scoring Variables **********

    var straight = false
    var fullHouse = false
    var threePair = false
    var threeOAK = false
    var fourOAK = false
    var fiveOAK = false
    var sixOAK = false
    var singles = false
    var pairs = 0

    var threeOAKFaceValue = 0
    var fourOAKFaceValue = 0
    var fiveOAKFaceValue = 0
    var sixOAKFaceValue = 0

    var scoringCombosArray = [String:Bool]()
    var currentScore: Int = 0
    var currentRollScoreLabel: SKLabelNode = SKLabelNode()

    // MARK: ********** User Interface Variables **********

    var menuArray = [SKSpriteNode]()
    var menuVisible = true

    let logo = SKLabelNode(text: "Farkle")
    let logo2 = SKLabelNode(text: "Plus")
    var mainMenuHolder: SKNode = SKNode()
    var settingsMenuHolder: SKNode = SKNode()
    var iconWindowIconsHolder: SKNode = SKNode()
    var gameTableHolder: SKNode = SKNode()
    var gameTable = SKSpriteNode()
    var background = SKSpriteNode()
    var mainMenu: SKSpriteNode = SKSpriteNode()
    var settingsMenu: SKSpriteNode = SKSpriteNode()
    var helpMenu: SKSpriteNode = SKSpriteNode()
    var mainMenuLabel: SKLabelNode = SKLabelNode()
    var settingsMenuLabel: SKLabelNode = SKLabelNode()
    var soundButtonLabel: SKLabelNode = SKLabelNode()
    var backButtonLabel: SKLabelNode = SKLabelNode()
    var newGameButtonLabel: SKLabelNode = SKLabelNode()
    var settingsButtonLabel: SKLabelNode = SKLabelNode()
    var resumeButtonLabel: SKLabelNode = SKLabelNode()
    var exitButtonLabel: SKLabelNode = SKLabelNode()
    var rollDiceButtonLabel: SKLabelNode = SKLabelNode()
    var keepScoreButtonLabel: SKLabelNode = SKLabelNode()

    var newGameButton: SKSpriteNode = SKSpriteNode()
    var pauseButton: SKSpriteNode = SKSpriteNode()
    var exitButton: SKSpriteNode = SKSpriteNode()
    var soundButton: SKSpriteNode = SKSpriteNode()
    var infoButton: SKSpriteNode = SKSpriteNode()
    var menuButton: SKSpriteNode = SKSpriteNode()
    var resumeGameButton: SKSpriteNode = SKSpriteNode()
    var settingsButton: SKSpriteNode = SKSpriteNode()
    var homeButton: SKSpriteNode = SKSpriteNode()
    var backButton: SKSpriteNode = SKSpriteNode()
    var iconTouched: String = String("")
    var rollDiceButton: SKSpriteNode = SKSpriteNode()
    var keepScoreButton: SKSpriteNode = SKSpriteNode()

    var buttonWindow: SKSpriteNode = SKSpriteNode()
    var scoresWindow: SKSpriteNode = SKSpriteNode()

    var mainMenuButtonsArray = [SKSpriteNode]()
    var settingsMenuButtonsArray = [SKSpriteNode]()
    var buttonWindowButtonsArray = [SKSpriteNode]()

    // MARK: ********** Touches Variables **********

    var touchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var currentTouch: UITouch = UITouch()
    var currentTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var buttonWindowTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var gameTableTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var mainMenuTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var settingsMenuTouchLocation: CGPoint = CGPoint(x: 0, y: 0)

    let handlerBlock: (Bool) -> Void = {
        if $0 {
            var finished = false
            finished.toggle()
        }
    }

    var scoreTally = [Int]()

    // MARK: ********** didMove Section **********

    override func didMove(to view: SKView) {
        setupBackGround()
        setupGameTable()
        setupPlayers()
        setupCurrentRollScoreLabel()
        setupLogo()
        setupButtonWindow()
        setupScoresWindow()
        setupMainMenu()
        setupSettingsMenu()
        setupHelpMenu()
        menuArray = [mainMenu, settingsMenu, helpMenu]
        showMenu(menu: mainMenu)
        getPlaceHolders()
        setupDice()
        setupScoringCombosArray()
    }

    // MARK: ********** Touches Section **********

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let positionInScene = touch.location(in: self)
            let touchedNode = atPoint(positionInScene)
            handleTouches(TouchedNode: touchedNode)
            touchLocation = touch.location(in: self)
        } else {
            print("no touch detected")
        }
    }

    func handleTouches(TouchedNode: SKNode) {
        var dieName = ""
        let touchedNode = TouchedNode
        if let name = touchedNode.name {
            dieName = name
            switch name {
            case "NewGameButton":
                newGameButtonTouched()

            case "ResumeGameButton":
                resumeGameButtonTouched()

            case "SettingsButton":
                settingsButtonTouched()

            case "ExitButton":
                exitButtonTouched()

            case "InfoButton":
                infoButtonTouched()

            case "BackButton":
                backButtonTouched()

            case "SoundButton":
                soundButtonTouched()

            case "RollButton":
                if menuVisible {
                    return
                } else {
                    rollDice()
                }

            case "KeepButton":
                if menuVisible {
                    return
                } else {
                    keepScoreButtonTouched()
                }

            case "PauseButton":
                if menuVisible {
                    return
                } else {
                    pauseButtonTouched()
                }

            case "NumberOfPlayersInput":
                print("num of players touched")

            case "NumberOfDiceInput":
                print("num of dice touched")

            case "TargetScoreInput":
                print("target score input touched")

            case "MatchScoreOff":
                print("match score off touched")

            case "MatchScoreOn":
                print("match score on touched")

            default:
                break
            }

            for die in currentDiceArray {
                if dieName == die.name {
                    handleTouchedDie(TouchedNode: touchedNode, die: die)
                }
            }
        }
    }

    func handleTouchedDie(TouchedNode: SKNode, die: Die) {
        let count = die.dieFace!.countThisRoll
        if die.dieFace!.countThisRoll >= 3 {
            for Die in currentDiceArray where Die.dieFace!.countThisRoll == count {
                Die.selected = true
                selectedDieArray.append(die)
                switch die.dieFace!.countThisRoll {
                case 3:
                    threeOAK = true
                    //currentScore = calcMultiDieScore(count: 3)
                    //die.dieFace!.countThisRoll = 0
                    scoreDice(key: "ThreeOAK", isComplete: handlerBlock)
                case 4:
                    fourOAK = true
                    //currentScore = calcMultiDieScore(count: 4)
                    //die.dieFace!.countThisRoll = 0
                    scoreDice(key: "FourOAK", isComplete: handlerBlock)
                case 5:
                    fiveOAK = true
                    //currentScore = calcMultiDieScore(count: 5)
                    //die.dieFace!.countThisRoll = 0
                    scoreDice(key: "FiveOAK", isComplete: handlerBlock)
                case 6:
                    sixOAK = true
                    //currentScore = calcMultiDieScore(count: 6)
                    //die.dieFace!.countThisRoll = 0
                    scoreDice(key: "SixOAK", isComplete: handlerBlock)
                default:
                    break
                }
                die.dieFace!.countThisRoll = 0
                currentPlayer.currentRollScore += currentScore
                print("currentScore: \(currentScore), currentPlayerCurrentRollScore: \(currentPlayer.currentRollScore)")
                moveDiceCollection(count: die.dieFace!.countThisRoll)
            }
        } else {
            print("\((die.dieFace?.faceValue)!) touched")
            die.physicsBody = nil
            die.zRotation = 0
            die.position = die.placeHolder.position
            die.selected = true
            selectedDieArray.append(die)
        }
        getScoringCombos(isComplete: handlerBlock)
    }

    func wasMainMenuButtonTouched() {
        for button in mainMenuButtonsArray where button.contains(mainMenuTouchLocation) {
            switch button.name {
            case "NewGameButton":
                print("new game button touched")
                newGameButtonTouched()
            case "ResumeGameButton":
                print("resume game button touched")
                resumeGameButtonTouched()
            case "SettingsButton":
                print("resume game button touched")
                settingsButtonTouched()
            case "ExitButton":
                print("exit button touched")
                exitButtonTouched()
            case "InfoButton":
                print("info button touched")
                infoButtonTouched()
            default:
                print("main menu touched")
                break
            }
        }
    }

    func wasSettingsMenuButtonTouched() {
        for button in settingsMenuButtonsArray where button.contains(settingsMenuTouchLocation) {
            switch button.name {
            case "SoundButton":
                soundButtonTouched()
            case "BackButton":
                backButtonTouched()
            default:
                print("settings menu touched")
                break
            }
        }
    }

    func wasButtonWindowButtonTouched() {
        for button in buttonWindowButtonsArray where button.contains(buttonWindowTouchLocation) {
            switch button.name {
            case "PauseButton":
                pauseButtonTouched()
            case "RollButton":
                rollDice()
            case "KeepButton":
                keepScoreButtonTouched()
            default:
                print("button window touched")
                break
            }
        }
    }

    /*
    func wasDiceTouched() {
        for die in scoringDiceArray {
            if die.contains(gameTableTouchLocation) {
                die.physicsBody?.categoryBitMask = 100
                die.physicsBody?.isDynamic = false
                die.selectable = false
                die.selected = true
                die.zRotation = 0
                if diePositionsArray.isEmpty {
                    // = positionsArray
                } else {
                    die.position = diePositionsArray.first!
                    diePositionsArray.removeFirst()
                }
            }
            //evalDice()
        }
    }
    */

    func newGameButtonTouched() {
        if gameState == .InProgress {
            gameInProgressMessage(on: scene!, title: "Game In Progress", message: GameConstants.Messages.GameInProgress)
        } else {
            hideMenu(menu: mainMenu)
            setupNewGame()
        }
    }

    func setupNewGame() {
        gameState = .InProgress
        currentGame = Game()
        resetDice()
        resetCurrentScoreVariables()
        resetCounters()
        resetArrays()
        resetScoringCombos()
        resetDiePhysics()
        resetDieVariables()
        resetPlayerScoreVariables()
        currentPlayerID = 0
    }

    func resumeGameButtonTouched() {
        if gameState == .NewGame {
            noGameInProgessMessage(on: scene!, title: "No Game In Progess", message: GameConstants.Messages.NoGameInProgress)
        } else {
            hideMenu(menu: mainMenu)
        }
    }

    func settingsButtonTouched() {
        if gameState == .InProgress {
            settingsMessage(on: scene!, title: "Game in Progress", message: GameConstants.Messages.Settings)
        } else {
            hideMenu(menu: mainMenu)
            showMenu(menu: settingsMenu)
        }
    }

    func exitButtonTouched() {
        print("game in progress")
        if gameState == .InProgress {
            gameInProgressMessage(on: scene!, title: "Game in Progress", message: GameConstants.Messages.GameInProgress)
        } else {
            gameOverMessage(on: scene!, title: "Game Over", message: GameConstants.Messages.GameOver)
            exit(0)
        }
    }

    func infoButtonTouched() {
        hideMenu(menu: mainMenu)
        showMenu(menu: helpMenu)
        print("Info Icon was Touched")
    }

    func soundButtonTouched() {
        print("sound icon touched")
    }

    func backButtonTouched() {
        print("back icon touched")
        hideMenu(menu: helpMenu)
        hideMenu(menu: settingsMenu)
        showMenu(menu: mainMenu)
    }

    func pauseButtonTouched() {
        showMenu(menu: mainMenu)
    }

    func keepScoreButtonTouched() {
        prepareForNextPlayer()
        nextPlayer()
    }

    func prepareForNextPlayer() {
        currentDiceArray = diceArray
        for die in currentDiceArray {
            die.selected = false
        }
        resetCurrentScoreVariables()
        resetDice()
        resetDiePhysics()
        resetCounters()
        resetArrays()
        returnDiceToHomePosition()
    }

    func nextPlayer() {
        if currentPlayerID < playersArray.count - 1 {
            currentPlayerID += 1
        } else {
            currentPlayerID = 0
        }
        currentPlayer = playersArray[currentPlayerID]
        currentPlayer.firstRoll = true
        currentPlayer.hasScoringDice = false
        playerNameLabel.text = "\(currentPlayer.name):"
    }

    func startNewRoll() {
        resetDice()
        resetCounters()
        currentPlayer.firstRoll = true
        currentPlayer.hasScoringDice = false
        rollDice()
    }

    func startNewRound() {
        currentPlayerID = 0
        resetDice()
        for player in playersArray {
            player.currentRollScore = 0
            player.firstRoll = true
        }
        currentGame.numRounds += 1
    }

    func showMenu(menu: SKSpriteNode) {
        menuVisible = true
        let currentMenu = menu
        currentMenu.xScale = 2
        currentMenu.yScale = 2
        currentMenu.position = CGPoint(x: 0, y: 0)
    }

    func hideMenu(menu: SKSpriteNode) {
        menuVisible = false
        let currentMenu = menu
        currentMenu.xScale = 0.25
        currentMenu.yScale = 0.25
        switch currentMenu.name {
        case "MainMenu":
            currentMenu.position = CGPoint(x: 500, y: -150)
        case "SettingsMenu":
            currentMenu.position = CGPoint(x: 500, y: 0)
        case "HelpMenu":
            currentMenu.position = CGPoint(x: 500, y: -150)
        default:
            break
        }
    }

    func resetCurrentScoreVariables() {
        currentPlayer.currentRollScore = 0
        currentScore = 0
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
    }

    // MARK: ********** Updates Section **********

    override func update(_ currentTime: TimeInterval) {
        displayScore()
    }
}
