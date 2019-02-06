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
    
    var GameTable: SKSpriteNode!
    var Menu: SKSpriteNode!
    var Label: SKLabelNode!
    var Button: SKSpriteNode!
    var ButtonLabel: SKLabelNode!
    
    var buttonPos1: CGPoint!
    var buttonPos2: CGPoint!
    var buttonPos3: CGPoint!
    
    var labelPos: CGPoint!

    override func didMove(to view: SKView) {
        setupGameTable()
        setupMenu(menuName: "MainMenu")
        setupButton(buttonName: "PlayButton", buttonNumber: 1)
        setupButton(buttonName: "SettingsButton", buttonNumber: 2)
        setupButton(buttonName: "HelpButton", buttonNumber: 3)
        setupMenuLabel(label: "Main Menu")
        setupButtonLabel(label: "Play", labelNumber: 1)
        setupButtonLabel(label: "Settings", labelNumber: 2)
        setupButtonLabel(label: "Help", labelNumber: 3)
    }
    
    func setupGameTable() {
        if let gameTable = SKSpriteNode(texture: SKTexture(imageNamed: "Felt_Green")) as SKSpriteNode? {
            self.GameTable = gameTable
            gameTable.name = "Game Table"
            gameTable.size = (scene?.size)!
            gameTable.position = CGPoint(x: 0, y: 0)
            
            self.addChild(gameTable)
        }
    }
    
    func setupMenu(menuName: String) {
        if let menu = SKSpriteNode(texture: SKTexture(imageNamed: "Casual Game GUI_Window - Wide")) as SKSpriteNode? {
            self.Menu = menu
            menu.name = menuName
            menu.size = CGSize(width: ((scene?.size.width)! / 2) + 100, height: ((scene?.size.height)! / 2) + 50)
            menu.position = CGPoint(x: (scene?.position.x)!, y: (scene?.position.y)!)
            menu.zPosition = 1

            self.addChild(menu)
        }
    }
    
    func setupButton(buttonName: String, buttonNumber: Int) {
        var pos = CGPoint()
        
        switch buttonNumber {
        case 1:
            pos = CGPoint(x: 0, y: 30)
            buttonPos1 = pos
        case 2:
            pos = CGPoint(x: 0, y: -20)
            buttonPos2 = pos
        case 3:
            pos = CGPoint(x: 0, y: -70)
            buttonPos3 = pos
        default:
            break
        }
        if let button = SKSpriteNode(texture: SKTexture(imageNamed: buttonName)) as SKSpriteNode? {
            self.Button = button
            button.name = buttonName
            button.position = pos
            button.size = CGSize(width: 128, height: 48)
            button.zPosition = 2
 
            self.addChild(button)
        }
    }

        /*
        if let settingsButton = SKSpriteNode(texture: SKTexture(imageNamed: "SettingsButton")) as SKSpriteNode? {
            self.button2 = settingsButton
            settingsButton.name = "Settings Button"
            settingsButton.position = CGPoint(x: 0, y: -20)
            settingsButton.size = CGSize(width: 128, height: 48)
            settingsButton.zPosition = 2

            self.addChild(settingsButton)
        }
        if let helpButton = SKSpriteNode(texture: SKTexture(imageNamed: "HelpButton")) as SKSpriteNode? {
            self.button3 = helpButton
            helpButton.name = "Help Button"
            helpButton.position = CGPoint(x: 0, y: -70)
            helpButton.size = CGSize(width: 128, height: 48)
            helpButton.zPosition = 2

            self.addChild(helpButton)
        }
    }*/
    
    func setupMenuLabel(label: String) {
        if let menuLabel = SKLabelNode(text: "Main Menu") as SKLabelNode? {
            self.Label = menuLabel
            menuLabel.text = label
            menuLabel.fontName = "Marker Felt Wide"
            menuLabel.fontColor = UIColor.black
            menuLabel.fontSize = 34
            menuLabel.zPosition = 3
            menuLabel.name = "\(label) Label"
            menuLabel.position = CGPoint(x: Menu.position.x, y: ((Menu.position.y) + (Menu.size.height / 2)) - 40)
            
            self.addChild(menuLabel)
        }
    }

    func setupButtonLabel(label: String, labelNumber: Int) {
        
        switch labelNumber {
        case 1:
            labelPos = CGPoint(x: 0, y: 22)
        case 2:
            labelPos = CGPoint(x: 0, y: ((self.buttonPos1.y) - (self.Button.size.height)) - 10)
        case 3:
            labelPos = CGPoint(x: 0, y: ((self.buttonPos2.y) - (self.Button.size.height)) - 10)
        default:
            break
        }
        if let buttonLabel = SKLabelNode(text: label) as SKLabelNode? {
            self.ButtonLabel = buttonLabel
            buttonLabel.text = label
            buttonLabel.fontName = "Marker Felt Wide"
            buttonLabel.fontColor = UIColor.black
            buttonLabel.fontSize = 24
            buttonLabel.zPosition = 3
            buttonLabel.name = "\(label) Label"
            buttonLabel.position = labelPos
            
            self.addChild(buttonLabel)
        }
    }
    
        /*
        if let playButtonLabel = SKLabelNode(text: "Play") as SKLabelNode? {
            self.ButtonLabel = playButtonLabel
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
            self.button2Label = settingsButtonLabel
            settingsButtonLabel.text = "Settings"
            settingsButtonLabel.fontName = "Marker Felt Wide"
            settingsButtonLabel.fontColor = UIColor.black
            settingsButtonLabel.fontSize = 24
            settingsButtonLabel.name = "Settings Button Label"
            settingsButtonLabel.position = CGPoint(x: 0, y: ((self.Button.position.y) - (self.Button.size.height)) - 10)
            //settingsButtonLabel.size = CGSize(width: 128, height: 64)
            settingsButtonLabel.zPosition = 3

            self.addChild(settingsButtonLabel)
        }
        if let helpButtonLabel = SKLabelNode(text: "Help") as SKLabelNode? {
            self.button3Label = helpButtonLabel
            helpButtonLabel.text = "Help"
            helpButtonLabel.fontName = "Marker Felt Wide"
            helpButtonLabel.fontColor = UIColor.black
            helpButtonLabel.fontSize = 24
            helpButtonLabel.name = "Help Button Label"
            helpButtonLabel.position = CGPoint(x: 0, y: ((self.button2.position.y) - (self.button2.size.height)) - 10)
            //helpButtonLabel = CGSize(width: 128, height: 64)
            helpButtonLabel.zPosition = 3

            self.addChild(helpButtonLabel)
        }
    }
    */
    
    override func update(_ currentTime: TimeInterval) {

    }
}
