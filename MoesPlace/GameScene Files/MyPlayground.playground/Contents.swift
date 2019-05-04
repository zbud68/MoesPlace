//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit
import UIKit

//let gameVC: GameViewController = GameViewController()

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
    
    @objc static override var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
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
                    handleTouchedDie(TouchedNode: touchedNode)
                }
            }
        }
    }

    func handleTouchedDie(TouchedNode: SKNode) {
        let touchedNode = TouchedNode as! SKSpriteNode
        if let name = touchedNode.name {
            switch name {
            case "Die1":
                if die1.dieFace!.countThisRoll >= 3 {
                    moveDiceCollection(count: die1.dieFace!.countThisRoll)
                } else {
                    print("\((die1.dieFace?.faceValue)!) touched")
                    die1.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    die1.physicsBody = nil
                    die1.zRotation = 0
                    die1.position = die1PlaceHolder.position
                    selectedDieArray.append(die1)
                }
                die1.selected = true

            case "Die2":
                if die2.dieFace!.countThisRoll >= 3 {
                    moveDiceCollection(count: die2.dieFace!.countThisRoll)
                } else {
                    print("\((die2.dieFace?.faceValue)!) touched")
                    die2.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    die2.physicsBody = nil
                    die2.zRotation = 0
                    die2.position = die2PlaceHolder.position
                    selectedDieArray.append(die2)
                }
                die2.selected = true
            case "Die3":
                if die3.dieFace!.countThisRoll >= 3 {
                    moveDiceCollection(count: die3.dieFace!.countThisRoll)
                } else {
                    print("\((die3.dieFace?.faceValue)!) touched")
                    die3.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    die3.physicsBody = nil
                    die3.zRotation = 0
                    die3.position = die3PlaceHolder.position
                    selectedDieArray.append(die3)
                }
                die3.selected = true
            case "Die4":
                if die4.dieFace!.countThisRoll >= 3 {
                    moveDiceCollection(count: die4.dieFace!.countThisRoll)
                } else {
                    print("\((die4.dieFace?.faceValue)!) touched")
                    die4.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    die4.physicsBody = nil
                    die4.zRotation = 0
                    die4.position = die4PlaceHolder.position
                    selectedDieArray.append(die4)
                }
                die4.selected = true
            case "Die5":
                if die5.dieFace!.countThisRoll >= 3 {
                    moveDiceCollection(count: die5.dieFace!.countThisRoll)
                } else {
                    print("\((die5.dieFace?.faceValue)!) touched")
                    die5.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    die5.physicsBody = nil
                    die5.zRotation = 0
                    die5.position = die5PlaceHolder.position
                    selectedDieArray.append(die5)
                }
                die5.selected = true
            case "Die6":
                if die6.dieFace!.countThisRoll >= 3 {
                    moveDiceCollection(count: die6.dieFace!.countThisRoll)
                } else {
                    print("\((die6.dieFace?.faceValue)!) touched")
                    die6.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    die6.physicsBody = nil
                    die6.zRotation = 0
                    die6.position = die6PlaceHolder.position
                    selectedDieArray.append(die6)
                }
                die6.selected = true
            default:
                break
            }
            getScoringCombos(isComplete: handlerBlock)
        }
        displayScore()
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
        // Called before each frame is rendered
        displayScore()
    }
}

//
//  Window_Ext.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

extension GameScene {
    func setupButtonWindow() {
        if let ButtonWindow = background.childNode(withName: "ButtonsWindow") as? SKSpriteNode {
            buttonWindow = ButtonWindow
        } else {
            print("Button window not found")
        }
        setupButtonWindowButtons()
    }

    func setupScoresWindow() {
        if let ScoresWindow = background.childNode(withName: "ScoresWindow") as? SKSpriteNode {
            scoresWindow = ScoresWindow
        } else {
            print("scores windows not found")
        }
    }
}


//
//  Utilities.swift
//  MoesPlace
//
//  Created by Mark Davis on 5/1/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
extension GameScene {

    func removeDuplicateInts(values: [Int]) -> [Int] {
        // Convert array into a set to get unique values.
        let uniques = Set<Int>(values)
        // Convert set back into an Array of Ints.
        let result = Array<Int>(uniques)
        return result
    }
}
//
//  UIAlerts.swift
//  MoesPlace
//
//  Created by Mark Davis on 4/9/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
extension GameScene {

    func gameInProgressMessage(on scene: SKScene, title: String, message: String) {
        let alert = UIAlertController(title: "Game In Progress", message: GameConstants.Messages.GameInProgress, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Continue", style: .destructive, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            self.gameState = .NewGame
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))

        scene.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }

    func noGameInProgessMessage(on scene: SKScene, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil) }))

        scene.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }

    func gameOverMessage(on scene: SKScene, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil) }))

        scene.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }

    func farkleMessage(on scene: SKScene, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil) }))

        scene.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }

    func settingsMessage(on scene: SKScene, title: String, message: String) {
        let alert = UIAlertController(title: "Game In Progress", message: GameConstants.Messages.Settings, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Continue", style: .destructive, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            self.gameState = .NewGame
            self.hideMenu(menu: self.mainMenu)
            self.showMenu(menu: self.settingsMenu)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            self.showMenu(menu: self.mainMenu)
        }))

        scene.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)

    }
}


//
//  Scoring_Ext.swift
//  MoesPlace
//
//  Created by Mark Davis on 5/3/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
extension GameScene {

    func setupScoringCombosArray() {
        scoringCombosArray = ["Straight":straight, "FullHouse":fullHouse, "ThreeOAK":threeOAK, "FourOAK":fourOAK, "FiveOAK":fiveOAK, "Singles":singles]
        if currentGame.numDice == 6 {
            scoringCombosArray["ThreePair"] = threePair
            scoringCombosArray["SixOAK"] = sixOAK
        }
    }

    func rollDice() {
        currentScore = 0
        currentPlayer.hasScoringDice = false
        resetDiePhysics()
        if currentDiceArray.isEmpty {
            //print("new roll started")
            startNewRoll()
        } else {
            getDieSides()
        }
        displayScore()
        print("current score: \(currentScore)")
        print("current player current roll score: \(currentPlayer.currentRollScore)")
        print("current roll score label: \(currentRollScoreLabel.text!)")
    }

    func countDice(isComplete: (Bool) -> Void) {
        resetDieCount()
        rollDiceAction()
        var value = Int()
        for die in currentDiceArray {
            value = Int(arc4random_uniform(6)+1)
            switch value {
            case 1:
                dieFace1.countThisRoll += 1
                die.dieFace = dieFace1
            case 2:
                dieFace2.countThisRoll += 1
                die.dieFace = dieFace2
            case 3:
                dieFace3.countThisRoll += 1
                die.dieFace = dieFace3
            case 4:
                dieFace4.countThisRoll += 1
                die.dieFace = dieFace4
            case 5:
                dieFace5.countThisRoll += 1
                die.dieFace = dieFace5
            case 6:
                dieFace6.countThisRoll += 1
                die.dieFace = dieFace6
            default:
                break
            }
            dieFacesArray.append(die.dieFace!.faceValue)

            //print("dieValue: \(die.dieFace!.faceValue), dieCount: \(die.dieFace!.countThisRoll)")
        }

        /*
         for die in currentDiceArray {
         if die.dieFace!.faceValue == 1 || die.dieFace!.faceValue == 5 {
         scoringCombosArray["Singles"] = true
         }
         }
         */

        //let uniqueDieFaces = removeDuplicateInts(values: dieFacesArray)
        //print(dieFacesArray)
        //print(uniqueDieFaces)
        //dieFacesArray = uniqueDieFaces
        //print(dieFacesArray)

        isComplete(true)
    }

    func getScoringCombos(isComplete: (Bool) -> Void) {
        for die in currentDiceArray where die.selected {
            print("dieCount: \(die.dieFace!.countThisRoll)")
            //print("dieFaceValue: \(die.dieFace!.faceValue), dieCount: \(die.dieFace!.countThisRoll)")
            let count = die.dieFace!.countThisRoll
            print("count: \(count)")
            switch count {
            case 1:
                //print("single \(die.dieFace!.faceValue) found")
                if die.dieFace!.faceValue == 1 || die.dieFace!.faceValue == 5 {
                    currentPlayer.hasScoringDice = true
                    singles = true
                    scoreDice(key: "Singles", isComplete: handlerBlock)
                }

            case 2:
                //print("pair of \(die.dieFace!.faceValue)'s found")
                if die.dieFace!.faceValue == 1 || die.dieFace!.faceValue == 5 {
                    currentPlayer.hasScoringDice = true
                    singles = true
                    scoreDice(key: "Singles", isComplete: handlerBlock)
                }
                pairs += 1

            case 3:
                threeOAK = true
                if pairs == 1 {
                    fullHouse = true
                    threeOAK = false
                    pairs = 0
                    scoreDice(key: "FullHouse", isComplete: handlerBlock)
                } else {
                    threeOAKFaceValue = die.dieFace!.faceValue
                    scoreDice(key: "ThreeOAK", isComplete: handlerBlock)
                    die.dieFace!.countThisRoll = 0
                }
                currentPlayer.hasScoringDice = true

            case 4:
                fourOAK = true
                threeOAKFaceValue = die.dieFace!.faceValue
                currentPlayer.hasScoringDice = true
                scoreDice(key: "FourOAK", isComplete: handlerBlock)
                die.dieFace!.countThisRoll = 0

            case 5:
                fiveOAK = true
                fiveOAKFaceValue = die.dieFace!.faceValue
                currentPlayer.hasScoringDice = true
                scoreDice(key: "FiveOAK", isComplete: handlerBlock)
                die.dieFace!.countThisRoll = 0

            case 6:
                sixOAK = true
                sixOAKFaceValue = die.dieFace!.faceValue
                currentPlayer.hasScoringDice = true
                scoreDice(key: "SixOAK", isComplete: handlerBlock)
                die.dieFace!.countThisRoll = 0

            default:
                break
            }
            print("Die Value: \(die.dieFace!.faceValue), Die Count: \(die.dieFace!.countThisRoll)")
        }

        if pairs == 3 {
            threePair = true
            pairs = 0
            currentPlayer.hasScoringDice = true
            scoreDice(key: "ThreePair", isComplete: handlerBlock)
        }
        print("Scoring Keys: \(scoringCombosArray.keys)")
        print("Scoring Values: \(scoringCombosArray.values)")

        currentDiceArray.removeAll(where: { $0.selected })
        isComplete(true)
    }

    func scoreDice(key: String, isComplete: (Bool) -> Void) {
        for _ in scoringCombosArray.keys { //where key == combo {
            print("key is: \(key)")
            switch key {
            case "FullHouse":
                print("FullHouse found")
                currentScore = 1250
                positionDice()
                startNewRoll()
            case "Straight":
                print("Straight found")
                currentScore = 1500
                positionDice()
                startNewRoll()
            case "ThreePair":
                //print("Three pair found")
                currentScore = 500
                pairs = 0
                positionDice()
                startNewRoll()
            case "ThreeOAK":
                print("three of a kind")
                currentScore = calcMultiDieScore(count: 3)
            case "FourOAK":
                //print("four of a kind")
                currentScore = calcMultiDieScore(count: 4)
            case "FiveOAK":
                //print("five of a kind")
                currentScore = calcMultiDieScore(count: 5)
            case "SixOAK":
                //print("six of a kind")
                currentScore = calcMultiDieScore(count: 6)
            case "Singles":
                if currentPlayer.hasScoringDice {
                    currentScore = calcSingleDice()
                } else {
                    farkle()
                }
            default:
                break
            }
            print("hasScoringDice: \(currentPlayer.hasScoringDice)")
            scoreTally.append(currentScore)
        }
        displayScore()
        print("score tally: \(scoreTally)")
        scoreTally.removeAll()

        resetScoringCombosArray()

        isComplete(true)
    }

    func displayScore() {
        currentPlayer.currentRollScore += currentScore
        currentRollScoreLabel.text = String(currentPlayer.currentRollScore)
        currentScore = 0
    }

    func checkForStraight() {
        currentDieValuesArray.removeAll()
        for die in currentDiceArray {
            currentDieValuesArray.append(die.dieFace!.faceValue)
        }
        //currentDieValuesArray = [2,3,5,1,4]
        currentDieValuesArray = currentDieValuesArray.sorted()
        if currentDieValuesArray == [1,2,3,4,5] || currentDieValuesArray == [2,3,4,5,6] || currentDieValuesArray == [1,2,3,4,5,6] {
            straight = true
            currentPlayer.hasScoringDice = true
            currentDieValuesArray.removeAll()
            scoreDice(key: "Straight", isComplete: handlerBlock)
            print("Straight: \(straight)")
        }
    }

    func moveDiceCollection(count: Int){

        let moveDie1 = SKAction.move(to: die1PlaceHolder.position, duration: 0.25)
        let moveDie2 = SKAction.move(to: die2PlaceHolder.position, duration: 0.25)
        let moveDie3 = SKAction.move(to: die3PlaceHolder.position, duration: 0.25)
        let moveDie4 = SKAction.move(to: die4PlaceHolder.position, duration: 0.25)
        let moveDie5 = SKAction.move(to: die5PlaceHolder.position, duration: 0.25)
        let moveDie6 = SKAction.move(to: die6PlaceHolder.position, duration: 0.25)

        for die in currentDiceArray where die.dieFace!.countThisRoll == count {
            die.selected = true
            die.physicsBody?.collisionBitMask = 2
            die.physicsBody?.isDynamic = false
            die.physicsBody?.allowsRotation = false

            switch die.name {
            case "Die1":
                die.zRotation = 0
                die.run(moveDie1)
            case "Die2":
                die.zRotation = 0
                die.run(moveDie2)
            case "Die3":
                die.zRotation = 0
                die.run(moveDie3)
            case "Die4":
                die.zRotation = 0
                die.run(moveDie4)
            case "Die5":
                die.zRotation = 0
                die.run(moveDie5)
            case "Die6":
                die.zRotation = 0
                die.run(moveDie6)
            default:
                break
            }
        }
        currentDiceArray.removeAll(where: { $0.selected })
    }

    func calcMultiDieScore(count: Int) -> Int {
        print("Calculating Scoring Combo")
        var result = 0
        for die in currentDiceArray where die.dieFace?.countThisRoll == count {
            if die.dieFace!.faceValue == 1 {
                result = (1000 * (count - 2))
                //die.dieFace!.countThisRoll = 0
            } else {
                result = ((die.dieFace!.faceValue * 100) * (count - 2))
                //die.dieFace!.countThisRoll = 0
            }
        }
        print("result: \(result)")
        return result
    }

    func calcSingleDice() -> Int {
        var result = 0
        for die in currentDiceArray where die.dieFace!.countThisRoll < 3 && die.selected {
            if die.dieFace!.faceValue == 1 {
                result += 100
            } else if die.dieFace!.faceValue == 5 {
                result += 50
            }
        }
        return result
    }

    func farkle() {
        runFarkleAction(isComplete: handlerBlock)
    }

    func runFarkleAction(isComplete: (Bool) -> Void) {
        let wait = SKAction.wait(forDuration: 0.25)
        let fadeOut = SKAction.fadeOut(withDuration: 0.25)
        let changeColorToRed = SKAction.run {
            self.logo.zPosition = GameConstants.ZPositions.Dice + 0.5
            self.logo.fontColor = UIColor.red
            self.logo2.zPosition = self.logo.zPosition
            self.logo2.fontColor = UIColor.red
        }
        let changeColorBack = SKAction.run {
            self.logo.zPosition = GameConstants.ZPositions.Logo
            self.logo.fontColor = GameConstants.Colors.LogoFont
            self.logo2.fontColor = GameConstants.Colors.LogoFont
            self.logo2.zPosition = GameConstants.ZPositions.Logo
        }

        let moveDie1 = SKAction.move(to: die1PlaceHolder.position, duration: 0.05)
        let moveDie2 = SKAction.move(to: die2PlaceHolder.position, duration: 0.05)
        let moveDie3 = SKAction.move(to: die3PlaceHolder.position, duration: 0.05)
        let moveDie4 = SKAction.move(to: die4PlaceHolder.position, duration: 0.05)
        let moveDie5 = SKAction.move(to: die5PlaceHolder.position, duration: 0.05)
        let moveDie6 = SKAction.move(to: die6PlaceHolder.position, duration: 0.05)

        let nextPlayer = SKAction.run {
            self.nextPlayer()
        }

        let rotateDice = SKAction.run {
            self.die1.zRotation = 0
            self.die2.zRotation = 0
            self.die3.zRotation = 0
            self.die4.zRotation = 0
            self.die5.zRotation = 0
            self.die6.zRotation = 0
            for die in self.currentDiceArray {
                die.physicsBody?.allowsRotation = false
            }
        }

        let moveDice1 = SKAction.run {
            for die in self.currentDiceArray {
                die.run(rotateDice)
            }
            self.die1.run(moveDie1)
            self.die2.run(moveDie2)
            self.die3.run(moveDie3)
            self.die4.run(moveDie4)
            self.die5.run(moveDie5)
        }

        let moveDice2 = SKAction.run {
            self.die1.run(moveDie1)
            self.die2.run(moveDie2)
            self.die3.run(moveDie3)
            self.die4.run(moveDie4)
            self.die5.run(moveDie5)
            self.die6.run(moveDie6)
        }

        let fadeIn = SKAction.fadeIn(withDuration: 0.25)
        let fadeTo = SKAction.fadeAlpha(to: 0.65, duration: 0.25)

        let seq1 = SKAction.sequence([wait, fadeOut, changeColorToRed, fadeIn, fadeOut, fadeIn, fadeOut, changeColorBack, fadeTo, wait, moveDice1, nextPlayer])

        let seq2 = SKAction.sequence([wait, fadeOut, changeColorToRed, fadeIn, fadeOut, fadeIn, fadeOut, changeColorBack, fadeTo, wait, moveDice2, nextPlayer])

        if currentGame.numDice == 5 {
            logo.run(seq1)
        } else {
            logo.run(seq2)
        }
        resetDice()
        isComplete(true)
    }

    func resetScoringCombos() {
        for (key, _) in scoringCombosArray {
            scoringCombosArray[key] = false
        }
    }

    func resetScoringCombosArray() {
        for (key,_) in scoringCombosArray {
            scoringCombosArray[key] = false
        }
    }

    func resetDieCount() {
        for die in currentDiceArray {
            die.dieFace?.countThisRoll = 0
        }
        for die in selectedDieArray {
            die.dieFace?.countThisRoll = 0
        }
    }

    func resetCounters() {
        pairs = 0
        for die in currentDiceArray {
            die.selected = false
            die.counted = false
        }
    }

    func resetDieVariables() {
        for die in currentDiceArray {
            die.selected = false
            die.counted = false
        }
        for die in selectedDieArray {
            die.selected = false
            die.counted = false
        }
    }
}
//
//  Player_Ext.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
extension GameScene {

    func setupPlayers() {
        player1.name = "Player 1"
        player2.name = "Player 2"
        player3.name = "Player 3"
        player4.name = "Player 4"

        player1.nameLabel.text = player1.name
        player2.nameLabel.text = player2.name
        player3.nameLabel.text = player3.name
        player4.nameLabel.text = player4.name

        switch currentGame.numPlayers {
        case 1:
            playersArray = [player1]
        case 2:
            playersArray = [player1, player2]
        case 3:
            playersArray = [player1, player2, player3]
        case 4:
            playersArray = [player1, player2, player3, player4]
        default:
            break
        }

        if let Player1ScoreLabel = scoresWindow.childNode(withName: "Player1ScoreLabel") as? SKLabelNode {
            player1.scoreLabel = Player1ScoreLabel
        }
        if let Player2ScoreLabel = scoresWindow.childNode(withName: "Player2ScoreLabel") as? SKLabelNode {
            player2.scoreLabel = Player2ScoreLabel
        }
        if let Player3ScoreLabel = scoresWindow.childNode(withName: "Player3ScoreLabel") as? SKLabelNode {
            player3.scoreLabel = Player3ScoreLabel
        }
        if let Player4ScoreLabel = scoresWindow.childNode(withName: "Player4ScoreLabel") as? SKLabelNode {
            player4.scoreLabel = Player4ScoreLabel
        }

        for player in playersArray {
            //player.name = player.nameLabel.text!
            player.scoreLabel.text = String(player.score)
            scoresWindow.addChild(player.nameLabel)
            scoresWindow.addChild(player.scoreLabel)
        }

        currentPlayer = playersArray.first
        positionPlayerLabels()
    }

    func positionPlayerLabels() {
        for player in playersArray {
            player.nameLabel.fontName = GameConstants.StringConstants.FontName
            player.scoreLabel.fontName = GameConstants.StringConstants.FontName
            player.nameLabel.fontSize = GameConstants.Sizes.PlayerNameLabelFont
            player.scoreLabel.fontSize = GameConstants.Sizes.PlayerScoreLabelFont
            player.nameLabel.fontColor = GameConstants.Colors.PlayerNameLabelFont
            player.scoreLabel.fontColor = GameConstants.Colors.PlayerScoreLabelFont
            player.nameLabel.zPosition = GameConstants.ZPositions.NameLabel
            player.scoreLabel.zPosition = GameConstants.ZPositions.ScoreLabel

            switch player.name {
            case "Player 1":
                player1.nameLabel.position = CGPoint(x: 0, y: (scoresWindow.frame.height / 4) + 15)

                player1.scoreLabel.position = CGPoint(x: player1.nameLabel.position.x, y: player1.nameLabel.position.y - 30)
            case "Player 2":
                player2.nameLabel.position = CGPoint(x: 0, y: player1.nameLabel.position.y - 60)

                player2.scoreLabel.position = CGPoint(x: player1.nameLabel.position.x, y: player2.nameLabel.position.y - 30)
            case "Player 3":
                player3.nameLabel.position = CGPoint(x: 0, y: player2.nameLabel.position.y - 60)

                player3.scoreLabel.position = CGPoint(x: player2.nameLabel.position.x, y: player3.nameLabel.position.y - 30)
            case "Player 4":
                player4.nameLabel.position = CGPoint(x: 0, y: player3.nameLabel.position.y - 60)

                player4.scoreLabel.position = CGPoint(x: player3.nameLabel.position.x, y: player4.nameLabel.position.y - 25)
            default:
                break
            }
        }
    }
}


//
//  Menus_Ext.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/20/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//


extension GameScene {
    func setupMainMenu() {
        if let MainMenu = gameTable.childNode(withName: "MainMenu") as? SKSpriteNode {
            mainMenu = MainMenu
        } else {
            print("main menu not found")
        }
        mainMenu.position = CGPoint(x: 0, y: 0)
        mainMenu.alpha = 1
    }

    func setupSettingsMenu() {
        if let SettingsMenu = gameTable.childNode(withName: "SettingsMenu") as? SKSpriteNode {
            settingsMenu = SettingsMenu
        } else {
            print("settings menu not found")
        }
        settingsMenu.position = CGPoint(x: 500, y: 0)
        setupSettingsMenuButtons()
    }

    func setupHelpMenu() {
        if let HelpMenu = gameTable.childNode(withName: "HelpMenu") as? SKSpriteNode {
            helpMenu = HelpMenu
        } else {
            print("help menu not found")
        }
        helpMenu.position = CGPoint(x: 500, y: -150)
    }

    func setupMainMenuButtons() {
        if let NewGameButton = mainMenu.childNode(withName: "NewGameButton") as? SKSpriteNode {
            newGameButton = NewGameButton
        } else {
            print("new game button not found")
        }

        if let ResumeGameButton = mainMenu.childNode(withName: "ResumeGameButton") as? SKSpriteNode {
            resumeGameButton = ResumeGameButton
        } else {
            print("resume game button not found")
        }

        if let SettingsButton = mainMenu.childNode(withName: "SettingsButton") as? SKSpriteNode {
            settingsButton = SettingsButton
        } else {
            print("settings button not found")
        }

        if let ExitButton = mainMenu.childNode(withName: "ExitButton") as? SKSpriteNode {
            exitButton = ExitButton
        } else {
            print("exit button not found")
        }

        if let InfoButton = mainMenu.childNode(withName: "InfoButton") as? SKSpriteNode {
            infoButton = InfoButton
        } else {
            print("info button not found")
        }

        setupButtonArrays()
    }

    func setupMainMenuLabels() {
        mainMenuLabel.text = "Main Menu"
        mainMenuLabel.fontName = GameConstants.StringConstants.FontName
        mainMenuLabel.fontSize = GameConstants.Sizes.MainMenuFont
        mainMenuLabel.fontColor = GameConstants.Colors.MainMenuFont
        mainMenuLabel.zPosition = GameConstants.ZPositions.MenuLabel
        mainMenuLabel.position = CGPoint(x: 0, y: mainMenu.frame.maxY - (mainMenuLabel.fontSize + (mainMenuLabel.fontSize / 3)))

        newGameButtonLabel.text = "New Game"
        newGameButtonLabel.fontName = GameConstants.StringConstants.FontName
        newGameButtonLabel.fontSize = GameConstants.Sizes.IconLabelFont
        newGameButtonLabel.fontColor = GameConstants.Colors.IconLabelFont
        newGameButtonLabel.zPosition = GameConstants.ZPositions.IconLabel
        newGameButtonLabel.position = CGPoint(x: 65, y: -8)

        resumeButtonLabel.text = "Continue"
        resumeButtonLabel.fontName = GameConstants.StringConstants.FontName
        resumeButtonLabel.fontSize = GameConstants.Sizes.IconLabelFont
        resumeButtonLabel.fontColor = GameConstants.Colors.IconLabelFont
        resumeButtonLabel.zPosition = GameConstants.ZPositions.IconLabel
        resumeButtonLabel.position = CGPoint(x: 59, y: -8)

        settingsButtonLabel.text = "Settings"
        settingsButtonLabel.fontName = GameConstants.StringConstants.FontName
        settingsButtonLabel.fontSize = GameConstants.Sizes.IconLabelFont
        settingsButtonLabel.fontColor = GameConstants.Colors.IconLabelFont
        settingsButtonLabel.zPosition = GameConstants.ZPositions.IconLabel
        settingsButtonLabel.position = CGPoint(x: 58, y: -8)

        exitButtonLabel.text = "Exit Game"
        exitButtonLabel.fontName = GameConstants.StringConstants.FontName
        exitButtonLabel.fontSize = GameConstants.Sizes.IconLabelFont
        exitButtonLabel.fontColor = GameConstants.Colors.IconLabelFont
        exitButtonLabel.zPosition = GameConstants.ZPositions.IconLabel
        exitButtonLabel.position = CGPoint(x: 67, y: -8)
    }

    func setupSettingsMenuButtons() {
        if let SoundButton = settingsMenu.childNode(withName: "SoundButton") as? SKSpriteNode {
            soundButton = SoundButton
        } else {
            print("sound button not found")
        }

        if let BackButton = settingsMenu.childNode(withName: "BackButton") as? SKSpriteNode {
            backButton = BackButton
        } else {
            print("back button not found")
        }

        setupButtonArrays()
    }

    func setupSettingsMenuLabels() {
        settingsMenuLabel.text = "Settings Menu"
        settingsMenuLabel.fontName = GameConstants.StringConstants.FontName
        settingsMenuLabel.fontSize = GameConstants.Sizes.MainMenuFont
        settingsMenuLabel.fontColor = GameConstants.Colors.MainMenuFont
        settingsMenuLabel.zPosition = GameConstants.ZPositions.MenuLabel
        settingsMenuLabel.position = CGPoint(x: 0, y: settingsMenu.frame.maxY - (settingsMenuLabel.fontSize + (settingsMenuLabel.fontSize / 3)))
        soundButtonLabel.text = "Sound"
        soundButtonLabel.fontName = GameConstants.StringConstants.FontName
        soundButtonLabel.fontSize = GameConstants.Sizes.IconLabelFont
        soundButtonLabel.fontColor = GameConstants.Colors.IconLabelFont
        soundButtonLabel.zPosition = GameConstants.ZPositions.IconLabel
        soundButtonLabel.position = CGPoint(x: 65, y: -8)

        backButtonLabel.text = "Back"
        backButtonLabel.fontName = GameConstants.StringConstants.FontName
        backButtonLabel.fontSize = GameConstants.Sizes.IconLabelFont
        backButtonLabel.fontColor = GameConstants.Colors.IconLabelFont
        backButtonLabel.zPosition = GameConstants.ZPositions.IconLabel
        backButtonLabel.position = CGPoint(x: 59, y: -8)
    }

    func addMainMenu() {

        self.addChild(mainMenu)
        mainMenu.addChild(newGameButton)
        mainMenu.addChild(resumeGameButton)
        mainMenu.addChild(settingsButton)
        mainMenu.addChild(exitButton)
        mainMenu.addChild(infoButton)
        newGameButton.addChild(newGameButtonLabel)
        resumeGameButton.addChild(resumeButtonLabel)
        settingsButton.addChild(settingsButtonLabel)
        exitButton.addChild(exitButtonLabel)
    }

    func addSettingsMenu() {
        self.addChild(settingsMenu)
        settingsMenu.addChild(soundButton)
        soundButton.addChild(soundButtonLabel)
        settingsMenu.addChild(backButton)
        backButton.addChild(backButtonLabel)
    }
}

//
//  Icon_Ext.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//


extension GameScene {
    func setupButtonWindowButtons() {
        if let PauseButton = buttonWindow.childNode(withName: "PauseButton") as? SKSpriteNode {
            pauseButton = PauseButton

        } else {
            print("pause button not found")
        }

        if let RollDiceButton = buttonWindow.childNode(withName: "RollButton") as? SKSpriteNode {
            rollDiceButton = RollDiceButton
        } else {
            print("roll dice button not found")
        }

        if let KeepScoreButton = buttonWindow.childNode(withName: "KeepButton") as? SKSpriteNode {
            keepScoreButton = KeepScoreButton
        } else {
            print("keep button not found")
        }
        setupButtonArrays()
    }

    func setupButtonArrays() {
        mainMenuButtonsArray = [newGameButton, resumeGameButton, settingsButton, exitButton, infoButton]
        settingsMenuButtonsArray = [soundButton, backButton]
        buttonWindowButtonsArray = [pauseButton, rollDiceButton, keepScoreButton]
    }
}

//
//  GameTable_Ext.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

extension GameScene {

    func setupGameTable() {
        if let GameTable = background.childNode(withName: "GameTable") as? SKSpriteNode {
            gameTable = GameTable
        } else {
            print("game table not found")
        }
    }

    func animateGameTitle(isComplete: (Bool) -> Void) {
        var animateTitle = SKAction()
        if let animation = SKAction(named: "AnimateGameTitle") {
            animateTitle = animation
        } else {
            print("Animation not found")
        }
        let wait = SKAction.wait(forDuration: 3)

        animateTitle = SKAction.group([animateTitle, wait])
        logo.run(animateTitle)
        logo2.run(animateTitle)
        isComplete(true)
    }

    func setupLogo() {

        logo.fontName = GameConstants.StringConstants.FontName
        logo.fontColor = GameConstants.Colors.LogoFont
        logo.fontSize = GameConstants.Sizes.Logo1Font
        logo.alpha = 0.65
        logo.position = CGPoint(x: 0, y: -50)
        logo.zPosition = GameConstants.ZPositions.Logo

        logo2.fontName = GameConstants.StringConstants.FontName
        logo2.fontColor = GameConstants.Colors.LogoFont
        logo2.fontSize = GameConstants.Sizes.Logo2Font
        logo2.alpha = 0.65
        logo2.zRotation = 75

        logo2.zPosition = GameConstants.ZPositions.Logo
        logo2.position = CGPoint(x: -185, y: -25)
        gameTable.addChild(logo)
        logo.addChild(logo2)
    }

    func setupCurrentRollScoreLabel() {
        playerNameLabel.text = "\(currentPlayer.name):"
        playerNameLabel.fontName = GameConstants.StringConstants.FontName
        playerNameLabel.fontColor = GameConstants.Colors.LogoFont
        playerNameLabel.fontSize = GameConstants.Sizes.PlayerNameLabelFont
        playerNameLabel.position = CGPoint(x: (gameTable.frame.minX) + ((gameTable.size.width) / 3), y: (gameTable.frame.maxY) / 2)
        playerNameLabel.zPosition = GameConstants.ZPositions.Logo
        playerNameLabel.alpha = 0.65

        //currentRollScoreLabel.text = String(currentPlayer.currentRollScore)
        currentRollScoreLabel.fontName = GameConstants.StringConstants.FontName
        currentRollScoreLabel.fontColor = GameConstants.Colors.LogoFont
        currentRollScoreLabel.fontSize = GameConstants.Sizes.PlayerScoreLabelFont
        currentRollScoreLabel.position = CGPoint(x: playerNameLabel.position.x + 110, y: playerNameLabel.position.y)
        currentRollScoreLabel.zPosition = GameConstants.ZPositions.ScoreLabel
        currentRollScoreLabel.alpha = 0.65

        gameTable.addChild(currentRollScoreLabel)
        gameTable.addChild(playerNameLabel)

    }
}

//
//  GameConstants.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/5/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

struct GameConstants {

    struct StringConstants {
        static let Player1Name = "Player 1"
        static let Player2Name = "Player 2"
        static let Player3Name = "Player 3"
        static let Player4Name = "Player 4"

        static let Die1Name = "Die1"
        static let Die2Name = "Die2"
        static let Die3Name = "Die3"
        static let Die4Name = "Die4"
        static let Die5Name = "Die5"
        static let Die6Name = "Die6"

        static let BackGroundName = "BackGround"
        static let GameTableName = "GameTable"
        static let IconWindowName = "IconWindow"
        static let ScoresWindowName = "ScoresWindow"
        static let MainMenuName = "MainMenu"
        static let SettingsMenuName = "SettingsMenu"

        static let IconWindowImageName = "WindowPopup1"
        static let ScoresWindowImageName = "WindowPopup2"
        static let GameTableImageName = "WindowPopup"
        static let MainMenuImageName = "MainMenu"
        static let SettingsMenuImageName = "SettingsMenu"
        static let HelpMenuImageName = "HelpMenu"
        static let BackGroundImageName = "Felt_Green"

        static let FontName = "Marker Felt Wide"
    }

    struct Textures {
        //static let DieTexture = SKTexture(imageNamed: "\(die.dieName)")
        static let Die1 = SKTexture(imageNamed: "Die1")
        static let Die2 = SKTexture(imageNamed: "Die2")
        static let Die3 = SKTexture(imageNamed: "Die3")
        static let Die4 = SKTexture(imageNamed: "Die4")
        static let Die5 = SKTexture(imageNamed: "Die5")
        static let Die6 = SKTexture(imageNamed: "Die6")

        static let MainMenu = SKTexture(imageNamed: "MainMenu")
        static let SettingsMenu = SKTexture(imageNamed: "SettingsMenu")
        static let GameTable = SKTexture(imageNamed: "WindowPopup")
        static let IconWindow = SKTexture(imageNamed: "WindowPopup1")
        static let ScoresWindow = SKTexture(imageNamed: "WindowPopup2")
        static let BackGround = SKTexture(imageNamed: "Felt_Green")
    }

    struct Sizes {
        static let Logo1Font = CGFloat(144)
        static let Logo2Font = CGFloat(34)
        static let PlayerNameLabelFont = CGFloat(25)
        static let PlayerScoreLabelFont = CGFloat(25)
        static let ScoresMenu = CGSize(width: 150, height: 330)
        static let ScoresMenuFont = CGFloat(34)
        static let MainMenuFont = CGFloat(34)
        static let IconLabelFont = CGFloat(18)
        static let Dice = CGSize(width: 48, height: 48)
    }

    struct Colors {
        static let LogoFont = UIColor.brown
        static let PlayerNameLabelFont = UIColor.darkText
        static let PlayerScoreLabelFont = UIColor.darkText
        static let ScoresMenuFont = UIColor.darkText
        static let MainMenuFont = UIColor.darkText
        static let IconLabelFont = UIColor.darkText
    }

    struct ZPositions {
        static let BackGround: CGFloat = 0
        static let GameTable: CGFloat = 5
        static let Window: CGFloat = 5
        static let Logo: CGFloat = 10
        static let Icon: CGFloat = 10
        static let IconLabel: CGFloat = 10
        static let NameLabel: CGFloat = 10
        static let ScoreLabel:  CGFloat = 10
        static let Dice: CGFloat = 15
        static let Message: CGFloat = 20
        static let Menu: CGFloat = 20
        static let MenuLabel: CGFloat = 20
    }

    struct PhysicsCategory {
        static let Dice = UInt32(1)
        static let Frame = UInt32(2)
    }

    struct Messages {
        static let GameInProgress = "There is currently a game in progress. Press 'Continue' to abandon game in progress and return to main menu, or 'Cancel' and press 'Resume Game' from main menu to contiue the game in progress"
        static let NoGameInProgress = "There is no game in progress, select 'New Game' from the main menu to start a new game"
        static let Winner = "has won the game."
        static let GameOver = "Has finished the game.\n Remaining players have 1 final roll."
        static let Busted = "You must match the target score exactly to win"
        static let Farkle = "No scoring dice"
        static let Settings = "There is currently a game in progress, if you continue the current game will be aborted.  Press 'Continue' to abandon game in progress and continue to the Settings Menu, or 'Cancel' and press 'Resume Game' from main menu to contiue the game in progress"
    }

    struct Locations {
        static let MainMenu = CGPoint(x: 0, y: 0)
        static let SettingsMenu = CGPoint(x: 0, y: 0)
    }

    struct Positions {
        static let MainMenu = CGPoint(x: 500, y: 0)
    }

}

//
//  Dice_Ext.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

extension GameScene {
    func setupDieFacesArray() {
        dieFacesArray = [dieFace1.faceValue, dieFace2.faceValue, dieFace3.faceValue, dieFace4.faceValue, dieFace5.faceValue, dieFace6.faceValue]
    }

    func getPlaceHolders() {
        if let Die1PlaceHolder = gameTable.childNode(withName: "Die1PlaceHolder") as? SKSpriteNode {
            die1PlaceHolder = Die1PlaceHolder
        }

        if let Die2PlaceHolder = gameTable.childNode(withName: "Die2PlaceHolder") as? SKSpriteNode {
            die2PlaceHolder = Die2PlaceHolder
        }

        if let Die3PlaceHolder = gameTable.childNode(withName: "Die3PlaceHolder") as? SKSpriteNode {
            die3PlaceHolder = Die3PlaceHolder
        }

        if let Die4PlaceHolder = gameTable.childNode(withName: "Die4PlaceHolder") as? SKSpriteNode {
            die4PlaceHolder = Die4PlaceHolder
        }

        if let Die5PlaceHolder = gameTable.childNode(withName: "Die5PlaceHolder") as? SKSpriteNode {
            die5PlaceHolder = Die5PlaceHolder
        }

        if let Die6PlaceHolder = gameTable.childNode(withName: "Die6PlaceHolder") as? SKSpriteNode {
            die6PlaceHolder = Die6PlaceHolder
        }
    }

    func setupDice() {
        if let Die1 = gameTable.childNode(withName: "Die1") as? Die {
            die1 = Die1
        } else {
            print("die1 not found")
        }

        if let Die2 = gameTable.childNode(withName: "Die2") as? Die {
            die2 = Die2
        } else {
            print("die2 not found")
        }

        if let Die3 = gameTable.childNode(withName: "Die3") as? Die {
            die3 = Die3
        } else {
            print("die3 not found")
        }

        if let Die4 = gameTable.childNode(withName: "Die4") as? Die {
            die4 = Die4
        } else {
            print("die4 not found")
        }

        if let Die5 = gameTable.childNode(withName: "Die5") as? Die {
            die5 = Die5
        } else {
            print("die5 not found")
        }

        if currentGame.numDice == 6 {
            if let Die6 = gameTable.childNode(withName: "Die6") as? Die {
                die6 = Die6
            } else {
                print("die6 not found")
            }
        }

        die1.texture = GameConstants.Textures.Die1
        die2.texture = GameConstants.Textures.Die2
        die3.texture = GameConstants.Textures.Die3
        die4.texture = GameConstants.Textures.Die4
        die5.texture = GameConstants.Textures.Die5
        die6.texture = GameConstants.Textures.Die6

        die1.dieFace = dieFace1
        die2.dieFace = dieFace2
        die3.dieFace = dieFace3
        die4.dieFace = dieFace4
        die5.dieFace = dieFace5
        die6.dieFace = dieFace6

        diceArray = [die1, die2, die3, die4, die5]

        if currentGame.numDice == 6 {
            diceArray.append(die6)
        } else {
            die6.removeFromParent()
            die6PlaceHolder.removeFromParent()
        }
        currentDiceArray = diceArray
        positionDice()
    }

    func positionDice() {
        for die in currentDiceArray {
            die.physicsBody = nil
            die.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            die.zRotation = 0
            die.size = GameConstants.Sizes.Dice

            switch die.name {
            case "Die1":
                die1.position = die1PlaceHolder.position
            case "Die2":
                die2.position = die2PlaceHolder.position
            case "Die3":
                die3.position = die3PlaceHolder.position
            case "Die4":
                die4.position = die4PlaceHolder.position
            case "Die5":
                die5.position = die5PlaceHolder.position
            case "Die6":
                die6.position = die6PlaceHolder.position
            default:
                break
            }
        }
        resetDiePhysics()
    }

    func getDieSides() {
        resetCounters()
        resetScoringCombos()
        dieFacesArray.removeAll()
        countDice(isComplete: handlerBlock)
        if currentPlayer.firstRoll {
            checkForStraight()
            getScoringCombos(isComplete: handlerBlock)
        }
    }


    func rollDiceAction() {
        for die in currentDiceArray {
            var rollAction: SKAction = SKAction()
            let Wait = SKAction.wait(forDuration: 0.15)

            if let RollAction = SKAction(named: "RollDice") {
                rollAction = RollAction
            }

            let MoveAction = SKAction.run {
                let randomX = CGFloat(arc4random_uniform(5) + 5)
                let randomY = CGFloat(arc4random_uniform(2) + 3)

                die.physicsBody?.applyImpulse(CGVector(dx: randomX, dy: randomY))
                die.physicsBody?.applyTorque(3)
            }
            let getDieSides = SKAction.run {
                self.setDieSides(die: die)
            }

            let Group = SKAction.group([rollAction, MoveAction])

            let Seq = SKAction.sequence([Group, Wait, getDieSides])

            die.position = CGPoint(x: 0, y: 0)
            die.run(Seq)
        }
    }

    func setDieSides(die: Die) {
        die.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        switch die.dieFace?.faceValue {
        case 1:
            die.texture = GameConstants.Textures.Die1
        case 2:
            die.texture = GameConstants.Textures.Die2
        case 3:
            die.texture = GameConstants.Textures.Die3
        case 4:
            die.texture = GameConstants.Textures.Die4
        case 5:
            die.texture = GameConstants.Textures.Die5
        case 6:
            die.texture = GameConstants.Textures.Die6
        default:
            break
        }
    }

    func returnDiceToHomePosition() {
        let moveDie1 = SKAction.move(to: die1PlaceHolder.position, duration: 0.25)
        let moveDie2 = SKAction.move(to: die2PlaceHolder.position, duration: 0.25)
        let moveDie3 = SKAction.move(to: die3PlaceHolder.position, duration: 0.25)
        let moveDie4 = SKAction.move(to: die4PlaceHolder.position, duration: 0.25)
        let moveDie5 = SKAction.move(to: die5PlaceHolder.position, duration: 0.25)
        let moveDie6 = SKAction.move(to: die6PlaceHolder.position, duration: 0.25)

        let rotateDice = SKAction.run {
            self.die1.zRotation = 0
            self.die2.zRotation = 0
            self.die3.zRotation = 0
            self.die4.zRotation = 0
            self.die5.zRotation = 0
            self.die6.zRotation = 0
            for die in self.currentDiceArray {
                die.physicsBody?.allowsRotation = false
            }
        }

        let moveDice1 = SKAction.run {
            for die in self.currentDiceArray {
                die.physicsBody?.collisionBitMask = 2
                die.physicsBody?.isDynamic = false
                die.run(rotateDice)
            }
            self.die1.run(moveDie1)
            self.die2.run(moveDie2)
            self.die3.run(moveDie3)
            self.die4.run(moveDie4)
            self.die5.run(moveDie5)
        }

        let moveDice2 = SKAction.run {
            for die in self.currentDiceArray {
                die.physicsBody?.collisionBitMask = 2
                die.physicsBody?.isDynamic = false
                die.run(rotateDice)
            }
            self.die1.run(moveDie1)
            self.die2.run(moveDie2)
            self.die3.run(moveDie3)
            self.die4.run(moveDie4)
            self.die5.run(moveDie5)
            self.die6.run(moveDie6)
        }

        let resetDice = SKAction.run {
            self.resetDieVariables()
        }

        let seq1 = SKAction.sequence([moveDice1, resetDice])

        let seq2 = SKAction.sequence([moveDice2, resetDice])

        for die in currentDiceArray {
            if currentGame.numDice == 5 {
                die.run(seq1)
            } else {
                die.run(seq2)
            }
        }
    }

    func resetDice() {
        currentDiceArray = diceArray
        selectedDieArray.removeAll()
        for die in currentDiceArray {
            die.selected = false
            die.counted = false
        }
        resetDiePhysics()
    }

    func resetDiePhysics() {
        for die in currentDiceArray {
            die.physicsBody = SKPhysicsBody(texture: die.texture!, size: die.size)
            die.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            die.physicsBody?.affectedByGravity = false
            die.physicsBody?.isDynamic = true
            die.physicsBody?.allowsRotation = true
            die.physicsBody?.categoryBitMask = 1
            die.physicsBody?.contactTestBitMask = 1
            die.physicsBody?.collisionBitMask = 1
            die.physicsBody?.restitution = 0.5
            die.physicsBody?.linearDamping = 4
            die.physicsBody?.angularDamping = 5
            die.zPosition = GameConstants.ZPositions.Dice
        }
    }
}

//
//  BackGround_Ext.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
extension GameScene {
    func setupBackGround() {

        if let Background = self.childNode(withName: "Background") as? SKSpriteNode {
            background = Background
        }
    }
}

//
//  Game.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/14/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

class Game {
    var numDice = 5
    var numPlayers = 2
    var targetScore = 10000
    var matchTargetScore = true
    var numRounds = 1

    let defaults: Defaults = Defaults()
}

struct Defaults {
    let numDice: Int = Int(5)
    let numPlayers: Int = Int(2)
    let targetScore: Int = Int(10000)
    let matchTargetScore: Bool = Bool(true)
}


//
//  Player.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

class Player {
    let nameLabel: SKLabelNode = SKLabelNode()
    var name: String

    var score: Int
    var currentRollScore: Int
    var scoreLabel: SKLabelNode = SKLabelNode()
    var hasScoringDice: Bool
    var firstRoll: Bool = true

    init(name: String, score: Int, currentRollScore: Int, hasScoringDice: Bool)
    {
        self.name = name
        self.score = score
        self.currentRollScore = currentRollScore
        self.hasScoringDice = hasScoringDice
    }
}




//
//  Die.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/22/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

class Die: SKSpriteNode {

    var selected: Bool = false
    var selectable: Bool = true
    var counted: Bool = false
    var dieFace: DieFace?
}



//
//  DieFace.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

class DieFace
{
    var faceValue : Int
    var countThisRoll : Int = 0

    init(faceValue: Int)
    {
        self.faceValue = faceValue
    }
}




// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
if let scene = GameScene(fileNamed: "GameScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView


