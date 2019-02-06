//
//  GameScene.swift
//  Farkle
//
//  Created by Mark Davis on 1/29/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var newGame: Bool = true
    
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
        if newGame == true {
            setupGameTable()
            setupMenus()
            setupButtons()
        }
        newGame = false
    }
    
    func setupGameTable() {
        //let sceneWidth = (scene?.size.width)!
        //let sceneHeight = (scene?.size.height)!
        
        if let gameTable = SKSpriteNode(texture: GameConstants.GameTable.Texture) as SKSpriteNode? {
            self.GameTable = gameTable
            gameTable.name = GameConstants.GameTable.Name
            //gameTable.size = CGSize(width: sceneWidth, height: sceneHeight)
            gameTable.position = GameConstants.GameTable.Position
            
            self.addChild(gameTable)
        }
    }
    
    func setupMenus() {
        setupMenu(menuName: "MainMenu")
        setupMenuLabel(label: "Main Menu")
    }
    
    func setupButtons() {
        setupButton(buttonName: "PlayButton", buttonNumber: 1)
        setupButton(buttonName: "SettingsButton", buttonNumber: 2)
        setupButton(buttonName: "HelpButton", buttonNumber: 3)
        
        setupButtonLabel(label: "Play", labelNumber: 1)
        setupButtonLabel(label: "Settings", labelNumber: 2)
        setupButtonLabel(label: "Help", labelNumber: 3)
    }
    
    func setupMenu(menuName: String) {
        if let menu = SKSpriteNode(texture: GameConstants.Menu.Texture) as SKSpriteNode? {
            self.Menu = menu
            menu.name = menuName
            menu.size = CGSize(width: ((scene?.size.width)! / 2) + 100, height: ((scene?.size.height)! / 2) + 50)
            menu.position = CGPoint(x: (scene?.position.x)!, y: (scene?.position.y)!)
            menu.zPosition = GameConstants.Menu.ZPos
            
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
        if let button = SKSpriteNode(texture: GameConstants.Button.Texture) as SKSpriteNode? {
            self.Button = button
            button.name = buttonName
            button.position = pos
            button.size = GameConstants.Button.Size
            button.zPosition = GameConstants.Button.ZPos
 
            self.addChild(button)
        }
    }

    func setupMenuLabel(label: String) {
        if let menuLabel = SKLabelNode(text: label) as SKLabelNode? {
            self.Label = menuLabel
            menuLabel.text = label
            menuLabel.fontName = GameConstants.Menu.fontName
            menuLabel.fontColor = GameConstants.Menu.fontColor
            menuLabel.fontSize = GameConstants.Menu.fontSize
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
            buttonLabel.fontName = GameConstants.Button.fontName
            buttonLabel.fontColor = GameConstants.Button.fontColor
            buttonLabel.fontSize = GameConstants.Button.fontSize
            buttonLabel.zPosition = 3
            buttonLabel.name = "\(label) Label"
            buttonLabel.position = labelPos
            
            self.addChild(buttonLabel)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {

    }
}
