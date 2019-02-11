//
//  BackGround_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    func setupBackGround() {
        BackGround = SKSpriteNode(texture: SKTexture(imageNamed: GameConstants.BackGround.ImageName))
        BackGround.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        BackGround.zPosition = GameConstants.ZPositions.BackGround
        BackGround.name = GameConstants.BackGround.Name
        BackGround.position = GameConstants.BackGround.Position
        
        backGroundMaxX = BackGround.frame.maxX
        backGroundMaxY = BackGround.frame.maxY
        backGroundMinX = BackGround.frame.minX
        backGroundMinY = BackGround.frame.minY
        backGroundWidth = BackGround.size.width
        backGroundHeight = BackGround.size.height

        self.addChild(BackGround)
    }
}
