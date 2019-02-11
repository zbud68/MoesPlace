//
//  Popup_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    func setupMenuLabel(label: String) {
        Label = SKLabelNode(text: label)
        Label.fontName = GameConstants.Label.FontName
        Label.fontColor = GameConstants.Label.FontColor
        Label.fontSize = GameConstants.Label.FontSize
        Label.zPosition = GameConstants.ZPositions.Window
        Label.name = "\(label) Label"
        Label.position = CGPoint(x: MainMenu.position.x, y: ((MainMenu.position.y) + (MainMenu.size.height / 2)) - 40)
    }
    
    func addWindows() {
        //if let iconWindow: SKSpriteNode = SKSpriteNode(imageNamed: GameConstants.StingConstants.IconWindowImageName) as SKSpriteNode?{
        //IconWindow = iconWindow
        
        /*
         //BackGround.addChild(ScoresWindow)
         }
         */
    }
    
    func addMenus() {
        //BackGround.addChild(MainMenu)
        //BackGround.addChild(SettingsMenu)
        //BackGround.addChild(HelpMenu)
    }
}
