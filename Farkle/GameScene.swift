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
var iconTouchLocation = CGPoint(x: 0, y: 0)
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
    
    var GameTable: SKSpriteNode!
    var BackGround: SKSpriteNode!
    var MainMenu: SKSpriteNode!
    var SettingsMenu: SKSpriteNode!
    var HelpMenu: SKSpriteNode!
    var Label: SKLabelNode!

    var labelPos = CGPoint()
    
    var PlayIcon: SKSpriteNode = SKSpriteNode()
    var PauseIcon: SKSpriteNode = SKSpriteNode()
    var ExitIcon: SKSpriteNode = SKSpriteNode()
    var SoundIcon: SKSpriteNode = SKSpriteNode()
    var InfoIcon: SKSpriteNode = SKSpriteNode()
    var MenuIcon: SKSpriteNode = SKSpriteNode()
    var RestartIcon: SKSpriteNode = SKSpriteNode()
    var SettingsIcon: SKSpriteNode = SKSpriteNode()
    var HomeIcon: SKSpriteNode = SKSpriteNode()
    var BackIcon: SKSpriteNode = SKSpriteNode()
    var iconTouched: String = String("")
    
    var IconWindow: SKSpriteNode = SKSpriteNode()
    var ScoresWindow: SKSpriteNode = SKSpriteNode()
    
    var Icons = [SKSpriteNode]()
    var Dice = [SKSpriteNode]()

    var Die1: SKSpriteNode!
    var Die2: SKSpriteNode!
    var Die3: SKSpriteNode!
    var Die4: SKSpriteNode!
    var Die5: SKSpriteNode!
    var Die6: SKSpriteNode!
    
    var maxX: CGFloat = CGFloat(0)
    var minX: CGFloat = CGFloat(0)
    var maxY: CGFloat = CGFloat(0)
    var minY: CGFloat = CGFloat(0)
    
    //MARK: ********** didMove Section **********
    override func didMove(to view: SKView) {
        maxX = view.frame.maxX
        maxY = view.frame.maxY
        minX = view.frame.minX
        minY = view.frame.minY
        
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
    
    //MARK: ********** Game Flow Methods Section **********
    func startNewGame() {
        setupBackGround()
        setupGameTable()
        //setupMenus()
        setupIconsArray()
        setupIcons()
        
        //addMenus()
        addWindows()
        addIcons()
        addDice()
        gameState = .InProgress
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
    
    //MARK: ********** Setup Elements Methods Section **********
    func setupBackGround() {
        BackGround = SKSpriteNode(texture: SKTexture(imageNamed: GameConstants.BackGround.ImageName))
        BackGround.zPosition = GameConstants.ZPositions.BackGround
        BackGround.name = GameConstants.BackGround.Name
        BackGround.position = GameConstants.BackGround.Position
        self.addChild(BackGround)
    }
    
    func setupGameTable() {
        if let gameTable = SKSpriteNode(imageNamed: "WindowPopup") as SKSpriteNode? {
            
            self.GameTable = gameTable
            gameTable.name = "Game Table"
            gameTable.zPosition = GameConstants.ZPositions.GameTable
            gameTable.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 750, height: 440)))
            gameTable.physicsBody?.affectedByGravity = GameConstants.GameTable.Gravity
            gameTable.physicsBody?.allowsRotation = GameConstants.GameTable.AllowsRotation
            gameTable.physicsBody?.isDynamic = GameConstants.GameTable.Dynamic
            //BackGround.addChild(gameTable)
        }
    }
    
    /*
    func setupMenus() {
        if let mainMenu = SKSpriteNode(texture: SKTexture(imageNamed: "MainMenu")) as SKSpriteNode? {
            mainMenu.name = "MainMenu"
            mainMenu.size = CGSize(width: ((scene?.size.width)! / 2) + 100, height: ((scene?.size.height)! / 2) + 50)
            mainMenu.position = CGPoint(x: (scene?.position.x)!, y: (scene?.position.y)!)
            mainMenu.zPosition = GameConstants.ZPositions.Menu
            self.MainMenu = mainMenu
            setupMenuLabel(label: "Main Menu")
        }
        
        if let settingsMenu = SKSpriteNode(texture: SKTexture(imageNamed: "SettingsMenu")) as SKSpriteNode? {
            settingsMenu.name = "SettingsMenu"
            settingsMenu.size = CGSize(width: ((scene?.size.width)! / 2) + 100, height: ((scene?.size.height)! / 2) + 50)
            settingsMenu.position = CGPoint(x: (scene?.position.x)!, y: (scene?.position.y)!)
            settingsMenu.zPosition = GameConstants.ZPositions.Menu
            self.SettingsMenu = settingsMenu
            setupMenuLabel(label: "Settings Menu")
        }
        
        if let helpMenu = SKSpriteNode(texture: SKTexture(imageNamed: "HelpMenu")) as SKSpriteNode? {
            helpMenu.name = "HelpMenu"
            helpMenu.size = CGSize(width: ((scene?.size.width)! / 2) + 100, height: ((scene?.size.height)! / 2) + 50)
            helpMenu.position = CGPoint(x: (scene?.position.x)!, y: (scene?.position.y)!)
            helpMenu.zPosition = GameConstants.ZPositions.Menu
            self.HelpMenu = helpMenu
            setupMenuLabel(label: "Help Menu")
        }
    }
    */
    
    func setupIconsArray() {
        if let playIcon = SKSpriteNode(imageNamed: "GreenPlay") as SKSpriteNode? {
            self.PlayIcon = playIcon
            PlayIcon.name = "Play Icon"
            Icons.append(PlayIcon)
        }
        if let exitIcon = SKSpriteNode(imageNamed: "GreenExit") as SKSpriteNode? {
            self.ExitIcon = exitIcon
            ExitIcon.name = "Exit Icon"
            Icons.append(ExitIcon)
        }
        if let soundIcon = SKSpriteNode(imageNamed: "GreenSound") as SKSpriteNode? {
            self.SoundIcon = soundIcon
            SoundIcon.name = "Sound Icon"
            Icons.append(SoundIcon)
        }
        if let infoIcon = SKSpriteNode(imageNamed: "GreenInfo") as SKSpriteNode? {
            self.InfoIcon = infoIcon
            InfoIcon.name = "Info Icon"
            Icons.append(InfoIcon)
        }
        if let menuIcon = SKSpriteNode(imageNamed: "GreenMenu") as SKSpriteNode? {
            self.MenuIcon = menuIcon
            MenuIcon.name = "Menu Icon"
            Icons.append(MenuIcon)
        }
        if let pauseIcon = SKSpriteNode(imageNamed: "GreenPause") as SKSpriteNode? {
            self.PauseIcon = pauseIcon
            PauseIcon.name = "Pause Icon"
            Icons.append(PauseIcon)
        }
        if let restartIcon = SKSpriteNode(imageNamed: "GreenReload") as SKSpriteNode? {
            self.RestartIcon = restartIcon
            RestartIcon.name = "Restart Icon"
            Icons.append(RestartIcon)
        }
        if let settingsIcon = SKSpriteNode(imageNamed: "GreenSettings") as SKSpriteNode? {
            self.SettingsIcon = settingsIcon
            SettingsIcon.name = "Settings Icon"
            Icons.append(SettingsIcon)
        }
        if let homeIcon = SKSpriteNode(imageNamed: "GreenHome") as SKSpriteNode? {
            self.HomeIcon = homeIcon
            HomeIcon.name = "Home Icon"
            Icons.append(HomeIcon)
        }
    }
    
    func setupDiceArray() {
        if let die1 = SKSpriteNode(imageNamed: "Die1") as SKSpriteNode? {
            Die1 = die1
            Die1.name = "Die 1"
            Dice.append(Die1)
        }
        if let die2 = SKSpriteNode(imageNamed: "Die2") as SKSpriteNode? {
            Die2 = die2
            Die2.name = "Die 2"
            Dice.append(Die2)
        }
        if let die3 = SKSpriteNode(imageNamed: "Die3") as SKSpriteNode? {
            Die3 = die3
            Die3.name = "Die 3"
            Dice.append(Die3)
        }
        if let die4 = SKSpriteNode(imageNamed: "Die4") as SKSpriteNode? {
            Die4 = die4
            Die4.name = "Die 4"
            Dice.append(Die4)
        }
        if let die5 = SKSpriteNode(imageNamed: "Die5") as SKSpriteNode? {
            Die5 = die5
            Die5.name = "Die 5"
            Dice.append(Die5)
        }
        if let die6 = SKSpriteNode(imageNamed: "Die6") as SKSpriteNode? {
            Die6 = die6
            Die6.name = "Die 6"
            Dice.append(Die6)
        }
    }
    
    func setupScoresWindow() {
        
    }

    func setupMenuLabel(label: String) {
        if let menuLabel = SKLabelNode(text: label) as SKLabelNode? {
            self.Label = menuLabel
            menuLabel.text = label
            menuLabel.fontName = GameConstants.Label.FontName
            menuLabel.fontColor = GameConstants.Label.FontColor
            menuLabel.fontSize = GameConstants.Label.FontSize
            menuLabel.zPosition = GameConstants.ZPositions.Menu
            menuLabel.name = "\(label) Label"
            menuLabel.position = CGPoint(x: MainMenu.position.x, y: ((MainMenu.position.y) + (MainMenu.size.height / 2)) - 40)
        }
    }
    
    func setupIcons() {
        for icon in Icons {
            icon.size = GameConstants.Icon.Size
            icon.isUserInteractionEnabled = true
            icon.zPosition = GameConstants.ZPositions.Icon
            
            switch icon.name {
            case "Play Icon":
                icon.position = CGPoint(x: 100, y: 100)
                PlayIcon.position = icon.position
            case "Exit Icon":
                icon.position = CGPoint(x: frame.maxX - 40, y: frame.maxY - 10)
                ExitIcon.position = icon.position
            case "Pause Icon":
                icon.position = CGPoint(x: frame.maxX - 10, y: frame.maxY - 50)
                PauseIcon.position = icon.position
            case "Sound Icon":
                icon.position = CGPoint(x: frame.maxX - 10, y: frame.minY + 10)
                SoundIcon.position = icon.position
            case "Info Icon":
                icon.position = CGPoint(x: frame.maxX - 40, y: frame.minY + 10)
                InfoIcon.position = icon.position
            default:
                break
            }
        }
    }
    
    //MARK: ********** Add Elements Methods Section **********
    func addGameTable() {
        //BackGround.addChild(GameTable)
    }
    
    func addBackGround() {
        //addChild(BackGround)
        
    }
    
    func addWindows() {
        
        print("entered AddWindows")
        //if let iconWindow: SKSpriteNode = SKSpriteNode(imageNamed: GameConstants.StingConstants.IconWindowImageName) as SKSpriteNode?{
            //IconWindow = iconWindow
        let iconWindow = SKSpriteNode(texture: SKTexture(imageNamed: "WindowPopup1"))
            print("iconWindow found")
        iconWindow.position = CGPoint(x: frame.midX, y: frame.midY)
                //CGPoint(x: maxX - 10, y: minY + 20 )
                //CGPoint(x: 150, y: 330)
            iconWindow.size = CGSize(width: 150, height: 100)
            iconWindow.zRotation = -90
            iconWindow.zPosition = 10
                //GameConstants.ZPositions.Menu
            iconWindow.name = "Icon Window"
            iconWindow.isHidden = true
            addChild(iconWindow)
        
        /*
        if let scoresWindow: SKSpriteNode = SKSpriteNode(imageNamed: GameConstants.StingConstants.ScoresWindowImageName) as SKSpriteNode? {
            print("Scores windows found")
            scoresWindow.position = CGPoint(x: (maxX - 20), y: ((IconWindow.size.width / 2) + (IconWindow.position.y)))
                //CGPoint(x: -45, y: 330)
            scoresWindow.size = CGSize(width: 150, height: 330)
            scoresWindow.zRotation = -90
            scoresWindow.zPosition = GameConstants.ZPositions.Menu
            ScoresWindow = scoresWindow
            ScoresWindow.name = "Player Scores Window"
            //BackGround.addChild(ScoresWindow)
        }
        */
    }
    
    func addIcons() {
        for icon in Icons {
            icon.zPosition = GameConstants.ZPositions.Icon
            //IconWindow.addChild(icon)
        }
    }
    
    func addMenus() {
        //BackGround.addChild(MainMenu)
        //BackGround.addChild(SettingsMenu)
        //BackGround.addChild(HelpMenu)
    }
    
    func addDice() {
        for die in Dice {
            die.zPosition = GameConstants.ZPositions.Dice
            //GameTable.addChild(die)
        }
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
