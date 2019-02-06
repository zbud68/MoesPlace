//
//  GameScene.swift
//  Farkle
//
//  Created by Mark Davis on 1/29/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

let gameScene = GameScene()

class GameScene: SKScene {
    
    var gameTable: SKSpriteNode!
    var mainMenu: SKSpriteNode!
    var mainMenuLabel: SKLabelNode!
    var playButton: SKSpriteNode!
    var playButtonLabel: SKLabelNode!
    var settingsButton: SKSpriteNode!
    var settingsButtonLabel: SKLabelNode!
    var helpButton: SKSpriteNode!
    var helpButtonLabel: SKLabelNode!

    override func didMove(to view: SKView) {
        loadGameTable()
        loadMainMenu()
        loadChildren()
        loadButtonLabels()
    }
    
    func loadGameTable() {
        if let gameTable = SKSpriteNode(texture: SKTexture(imageNamed: "Felt_Green")) as SKSpriteNode? {
            self.gameTable = gameTable
            gameTable.name = "Game Table"
            gameTable.size = (scene?.size)!
            gameTable.position = CGPoint(x: 0, y: 0)
            
            self.addChild(gameTable)
        }
    }
    
    func loadMainMenu() {
        if let mainMenu = SKSpriteNode(texture: SKTexture(imageNamed: "Casual Game GUI_Window - Wide")) as SKSpriteNode? {
            self.mainMenu = mainMenu
            mainMenu.name = "Main Menu"
            mainMenu.size = CGSize(width: ((scene?.size.width)! / 2) + 100, height: ((scene?.size.height)! / 2) + 50)
            mainMenu.position = CGPoint(x: (scene?.position.x)!, y: (scene?.position.y)!)
            mainMenu.zPosition = 1

            self.addChild(mainMenu)
        }
    }
    
    func loadChildren() {
        
        
        if let playButton = SKSpriteNode(texture: SKTexture(imageNamed: "PlayButton")) as SKSpriteNode? {
            self.playButton = playButton
            playButton.name = "Play Button"
            playButton.position = CGPoint(x: 0, y: 30)
            playButton.size = CGSize(width: 128, height: 48)
            playButton.zPosition = 2
 
            self.addChild(playButton)
        }
        if let settingsButton = SKSpriteNode(texture: SKTexture(imageNamed: "SettingsButton")) as SKSpriteNode? {
            self.settingsButton = settingsButton
            settingsButton.name = "Settings Button"
            settingsButton.position = CGPoint(x: 0, y: -20)
            settingsButton.size = CGSize(width: 128, height: 48)
            settingsButton.zPosition = 2

            self.addChild(settingsButton)
        }
        if let helpButton = SKSpriteNode(texture: SKTexture(imageNamed: "HelpButton")) as SKSpriteNode? {
            self.helpButton = helpButton
            helpButton.name = "Help Button"
            helpButton.position = CGPoint(x: 0, y: -70)
            helpButton.size = CGSize(width: 128, height: 48)
            helpButton.zPosition = 2

            self.addChild(helpButton)
        }
    }
    
    func loadButtonLabels() {
        if let mainMenuLabel = SKLabelNode(text: "Main Menu") as SKLabelNode? {
            self.mainMenuLabel = mainMenuLabel
            mainMenuLabel.text = "Main Menu"
            mainMenuLabel.fontName = "Marker Felt Wide"
            mainMenuLabel.fontColor = UIColor.black
            mainMenuLabel.fontSize = 34
            mainMenuLabel.zPosition = 3
            mainMenuLabel.name = "Main Menu Label"
            mainMenuLabel.position = CGPoint(x: mainMenu.position.x, y: ((mainMenu.position.y) + (mainMenu.size.height / 2)) - 40)
            
            self.addChild(mainMenuLabel)
        }
        
        if let playButtonLabel = SKLabelNode(text: "Play") as SKLabelNode? {
            self.playButtonLabel = playButtonLabel
            playButtonLabel.text = "Play"
            playButtonLabel.fontName = "Marker Felt Wide"
            playButtonLabel.fontColor = UIColor.black
            playButtonLabel.fontSize = 24
            playButtonLabel.name = "Play Button Label"
            playButtonLabel.position = CGPoint(x: 0, y: 22)
            //playButtonLabel.size = CGSize(width: 128, height: 64)
            playButtonLabel.zPosition = 3

            self.addChild(playButtonLabel)
        }
        if let settingsButtonLabel = SKLabelNode(text: "Settings") as SKLabelNode? {
            self.settingsButtonLabel = settingsButtonLabel
            settingsButtonLabel.text = "Settings"
            settingsButtonLabel.fontName = "Marker Felt Wide"
            settingsButtonLabel.fontColor = UIColor.black
            settingsButtonLabel.fontSize = 24
            settingsButtonLabel.name = "Settings Button Label"
            settingsButtonLabel.position = CGPoint(x: 0, y: ((self.playButton.position.y) - (self.playButton.size.height)) - 10)
            //settingsButtonLabel.size = CGSize(width: 128, height: 64)
            settingsButtonLabel.zPosition = 3

            self.addChild(settingsButtonLabel)
        }
        if let helpButtonLabel = SKLabelNode(text: "Help") as SKLabelNode? {
            self.helpButtonLabel = helpButtonLabel
            helpButtonLabel.text = "Help"
            helpButtonLabel.fontName = "Marker Felt Wide"
            helpButtonLabel.fontColor = UIColor.black
            helpButtonLabel.fontSize = 24
            helpButtonLabel.name = "Help Button Label"
            helpButtonLabel.position = CGPoint(x: 0, y: ((self.settingsButton.position.y) - (self.settingsButton.size.height)) - 10)
            //helpButtonLabel = CGSize(width: 128, height: 64)
            helpButtonLabel.zPosition = 3

            self.addChild(helpButtonLabel)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {

    }
}
