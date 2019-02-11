//
//  Window_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    func setupIconWindow() {
        IconWindow = SKSpriteNode(texture: SKTexture(imageNamed: "WindowPopup1"))
        IconWindow.size = CGSize(width: 165, height: (BackGround.size.height / 4))
        IconWindow.position = CGPoint(x: ((selfMinX + 5) + (IconWindow.size.width / 2)), y: ((selfMaxY - 10) - (IconWindow.size.height / 2)) )
        IconWindow.zPosition = GameConstants.ZPositions.Window
        IconWindow.name = "Icon Window"
        
        iconWindowMaxX = IconWindow.frame.maxY
        iconWindowMaxY = IconWindow.frame.maxY
        iconWindowMinX = IconWindow.frame.minX
        iconWindowMinY = IconWindow.frame.minY

        BackGround.addChild(IconWindow)
    }
    
    func setupScoresWindow() {
        ScoresWindow = SKSpriteNode(texture: SKTexture(imageNamed: "WindowPopup2"))
        ScoresWindow.size = CGSize(width: 165, height: (BackGround.size.height / 4) * 3)
        ScoresWindow.position = CGPoint(x: IconWindow.position.x, y: (IconWindow.position.y - (IconWindow.size.height * 2) + 5))
        ScoresWindow.zPosition = GameConstants.ZPositions.Window
        ScoresWindow.name = "Player Scores Window"
        
        scoresWindowMaxX = ScoresWindow.frame.maxY
        scoresWindowMaxY = ScoresWindow.frame.maxY
        scoresWindowMinX = ScoresWindow.frame.minX
        scoresWindowMinY = ScoresWindow.frame.minY
        scoresWindowWidth = ScoresWindow.size.width
        scoresWindowHeight = ScoresWindow.size.height
        
        BackGround.addChild(ScoresWindow)
    }

    
}
