//
//  Window_Ext.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    func setupButtonWindow() {
        if let ButtonWindow = background.childNode(withName: "ButtonsWindow") as? SKSpriteNode {
            buttonWindow = ButtonWindow
        } else {
            print("Button window not found")
        }


        //iconWindow = SKSpriteNode(texture: SKTexture(imageNamed: "WindowPopup1"))
        //iconWindow.size = CGSize(width: 165, height: ((background.size.height) / 4))
        //iconWindow.position = CGPoint(x: (((background.frame.minX)) + (iconWindow.size.width / 2)) + 5, y: (((background.frame.maxY)) - (iconWindow.size.height / 2)) - 10)
        //iconWindow.zPosition = GameConstants.ZPositions.Window
        //iconWindow.name = "Icon Window"

        //background.addChild(iconWindow)
        setupButtonWindowButtons()
    }

    func setupScoresWindow() {
        if let ScoresWindow = background.childNode(withName: "ScoresWindow") as? SKSpriteNode {
            scoresWindow = ScoresWindow
        } else {
            print("scores windows not found")
        }

        /*
        scoresWindow = SKSpriteNode(texture: SKTexture(imageNamed: "WindowPopup2"))
        scoresWindow.size = CGSize(width: 165, height: ((background.size.height) / 4) * 3)
        scoresWindow.position = CGPoint(x: iconWindow.position.x, y: (iconWindow.position.y - (iconWindow.size.height * 2) + 10))
        scoresWindow.zPosition = GameConstants.ZPositions.Window
        scoresWindow.name = "Player Scores Window"

        background.addChild(scoresWindow)
        */
    }
}
