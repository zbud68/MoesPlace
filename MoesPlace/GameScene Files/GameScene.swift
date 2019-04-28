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
    var diePositionsArray: [CGPoint] = [CGPoint]()
    var positionsArray: [CGPoint] = [CGPoint]()
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

    var reducedPositionArray: [CGPoint] = [CGPoint]()

    // MARK: ********** DieFace Variables **********

    var dieSide1: DieSide = DieSide(name: "Die1", value: 1, count: 0, points: 10)
    var dieSide2: DieSide = DieSide(name: "Die2", value: 2, count: 0, points: 2)
    var dieSide3: DieSide = DieSide(name: "Die3", value: 3, count: 0, points: 3)
    var dieSide4: DieSide = DieSide(name: "Die4", value: 4, count: 0, points: 4)
    var dieSide5: DieSide = DieSide(name: "Die5", value: 5, count: 0, points: 5)
    var dieSide6: DieSide = DieSide(name: "Die6", value: 6, count: 0, points: 6)

    var dieSidesArray: [DieSide] = [DieSide]()
    var currentRollArray: [DieSide] = [DieSide]()
    var currentDieValuesArray: [Int] = [Int]()
    var selectedDieArray: [Die] = [Die]()

    // MARK: ********** Scoring Variables **********

    let lowStraight: [Int] = [1, 2, 3, 4, 5]
    let highStraight: [Int] = [2, 3, 4, 5, 6]
    let sixDieStraight: [Int] = [1, 2, 3, 4, 5, 6]

    var straight = false
    var fullHouse = false
    var threePair = false
    var threeOAK: Bool = false
    var fourOAK: Bool = false
    var fiveOAK: Bool = false
    var sixOAK: Bool = false
    var pairs = 0

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

    var threeOAKValue = 0
    var fourOAKValue = 0
    var fiveOAKValue = 0
    var sixOAKValue = 0

    var ones = 0
    var twos = 0
    var threes = 0
    var fours = 0
    var fives = 0
    var sixes = 0

    var dots = [Int]()

    let handlerBlock: (Bool) -> Void = {
        if $0 {
            var finished = false
            finished.toggle()
        }
    }

    // MARK: ********** didMove Section **********

    override func didMove(to view: SKView) {
        setupBackGround()
        setupGameTable()
        //animateGameTitle(isComplete: handlerBlock)
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
        var dieName: String = ""
        // var dieTouched = false
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
                    //resetCounters()
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
                    //selectedDieArray.append(die)
                    handleTouchedDie(TouchedNode: touchedNode)
                    //print("selected Die: \(die.name!)")
                }
            }
        }
    }

    func handleTouchedDie(TouchedNode: SKNode) {
        let touchedNode = TouchedNode as! SKSpriteNode
        if let name = touchedNode.name {
            switch name {
            case "Die1":
                print("\(die1.dieSide!.value) touched")
                die1.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                die1.physicsBody = nil
                die1.selected = true
                die1.zRotation = 0
                die1.position = die1PlaceHolder.position
                selectedDieArray.append(die1)
                /*
                if die1.dieSide!.count >= 3  || die1.dieSide!.value == 1 || die1.dieSide!.value == 5 {
                    selectedDieArray.append(die1)
                    //currentDiceArray.removeAll(where: { $0.name == "Die2" })
                }
                die1.counted = true
                 */
            case "Die2":
                print("\(die2.dieSide!.value) touched")
                die2.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                die2.physicsBody = nil
                die2.selected = true
                die2.zRotation = 0
                die2.position = die2PlaceHolder.position
                selectedDieArray.append(die2)
                /*
                if die2.dieSide!.count >= 3  || die2.dieSide!.value == 1 || die2.dieSide!.value == 5 {
                    selectedDieArray.append(die2)
                    //currentDiceArray.removeAll(where: { $0.name == "Die2" })
                }
                die2.counted = true
                */
            case "Die3":
                print("\(die3.dieSide!.value) touched")
                die3.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                die3.physicsBody = nil
                die3.selected = true
                die3.zRotation = 0
                die3.position = die3PlaceHolder.position
                selectedDieArray.append(die3)
                /*
                if die3.dieSide!.count >= 3  || die3.dieSide!.value == 1 || die3.dieSide!.value == 5 {
                    selectedDieArray.append(die3)
                    //currentDiceArray.removeAll(where: { $0.name == "Die3" })
                }
                die3.counted = true
                */
            case "Die4":
                print("\(die4.dieSide!.value) touched")
                die4.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                die4.physicsBody = nil
                die4.selected = true
                die4.zRotation = 0
                die4.position = die4PlaceHolder.position
                selectedDieArray.append(die4)
                /*
                if die4.dieSide!.count >= 3  || die4.dieSide!.value == 1 || die4.dieSide!.value == 5 {
                    selectedDieArray.append(die4)
                    //currentDiceArray.removeAll(where: { $0.name == "Die4" })
                }
                die4.counted = true
                */
            case "Die5":
                print("\(die5.dieSide!.value) touched")
                die5.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                die5.physicsBody = nil
                die5.selected = true
                die5.zRotation = 0
                die5.position = die5PlaceHolder.position
                selectedDieArray.append(die5)
                /*
                if die5.dieSide!.count >= 3  || die5.dieSide!.value == 1 || die5.dieSide!.value == 5 {
                    selectedDieArray.append(die5)
                    //currentDiceArray.removeAll(where: { $0.name == "Die2" })
                }
                die5.counted = true
                */
            case "Die6":
                print("\(die6.dieSide!.value) touched")
                die6.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                die6.physicsBody = nil
                die6.selected = true
                die6.zRotation = 0
                die6.position = die6PlaceHolder.position
                selectedDieArray.append(die6)
                /*
                if die6.dieSide!.count >= 3 || die6.dieSide!.value == 1 || die6.dieSide!.value == 5 {
                    currentPlayer.hasScoringDice = true
                    selectedDieArray.append(die6)
                    //currentDiceArray.removeAll(where: { $0.name == "Die6" })
                }
                die6.counted = true
                */
            default:
                break
            }
        }
        currentDiceArray.removeAll(where: { $0.selected })
        for die in selectedDieArray {
            print("selected Die: \(die.dieSide!.value)")
        }
        //currentScore = 0
        evalDice()//(dice: selectedDieArray)
        //currentRollScoreLabel.text = String(currentPlayer.currentRollScore)
        //if !currentPlayer.firstRoll {
           // evalDice(dice: scoringDiceArray)//selectedDieArray)
       // } //else {
            //currentPlayer.firstRoll = false
            //evalDice(dice: scoringDiceArray) //currentDiceArray)
        //}
        //currentPlayer.currentRollScore += currentScore

        /*
        if currentPlayer.hasScoringDice == false {
            farkle()
        } else {
            if scoringDiceArray.count == currentDiceArray.count {
                //startNewRoll()
            }
        }
        */
    }

    /*
    func removeSelectedDie() {
        print("remove selected die")
        var id = 0
        for currentDie in currentDiceArray {
            for selectedDie in selectedDieArray {
                if selectedDie.name == currentDie.name {
                    currentDiceArray.remove(at: id)
                    print("selected Die Name: \(selectedDie.name!)")
                    print("\(currentDie.name!): removed")
                }
            }
            id += 1
        }
    }
    */

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
            evalDice()
            //if currentScore == 0 {
                //farkle()
                //return
            //}
        }
    }


    //func wasDiceTouched(touchedNode: SKNode) {
        /*
         for die in currentDiceArray where die.selected == false {
         if die.contains(gameTableTouchLocation) {
         print("dice touched")

         die.selected = true
         die.physicsBody?.collisionBitMask = 2
         die.physicsBody?.isDynamic = false
         die.physicsBody?.mass = 10000
         die.zRotation = 0
         if diePositionsArray.isEmpty {
         diePositionsArray = positionsArray
         } else {
         die.position = diePositionsArray.first!
         diePositionsArray.removeFirst()
         }
         if threeOAK || fourOAK || fiveOAK || sixOAK || fullHouse {
         scoringDiceArray.append(die)
         evalDice(dice: scoringDiceArray)
         }
         die.physicsBody = nil
         }
         }
         if !currentPlayer.firstRoll {
         evalDice(dice: currentDiceArray)
         } else {
         currentPlayer.firstRoll = false
         }
         for die in scoringDiceArray {
         die.counted = true
         }
         currentPlayer.currentRollScore += currentScore
         currentRollScoreLabel.text = String(currentPlayer.currentRollScore)
         */
    //}

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
        //showScoreTotal()
        //currentPlayer.score += currentPlayer.currentRollScore
        //currentPlayer.scoreLabel.text = String(currentPlayer.score)
        nextPlayer()
    }

    func nextPlayer() {
        currentDiceArray = diceArray
        resetDice()
        resetCounters()
        resetArrays()
        resetCurrentScoreVariables()
        returnDiceToHomePosition()
        /*
        for die in currentDiceArray {
            die.selected = false
            die.counted = false
        }
        */
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
        currentDiceArray = diceArray
        currentPlayer.firstRoll = true
        currentPlayer.hasScoringDice = false
        rollDice()
    }

    func startNewRound() {
        currentPlayerID = 0
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
        currentRollScoreLabel.text = String(0)
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
        //currentDiceArray = diceArray
    }

    func showScoreTotal() {
        currentPlayer.score += currentPlayer.currentRollScore
        print("current roll score: \(currentPlayer.currentRollScore)")
        currentPlayer.currentRollScore = 0
        print("current Score: \(currentPlayer.score)")
    }

    // MARK: ********** Updates Section **********

    override func update(_ currentTime: TimeInterval) {
        currentRollScoreLabel.text = String(currentPlayer.currentRollScore)
    }
}
