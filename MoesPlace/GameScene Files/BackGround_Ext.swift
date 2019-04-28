//
//  BackGround_Ext.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    func setupBackGround() {

        if let Background = self.childNode(withName: "Background") as? SKSpriteNode {
            background = Background
        }
        //backGround = SKSpriteNode(texture: SKTexture(imageNamed: GameConstants.StringConstants.BackGroundImageName))
        /*
        backGround.size = CGSize(width: frame.size.width, height: frame.size.height)
        backGround.zPosition = GameConstants.ZPositions.BackGround
        backGround.name = GameConstants.StringConstants.BackGroundName
        backGround.position = CGPoint(x: 0, y: 0)
        */

        //addChild(Background)
    }
}
