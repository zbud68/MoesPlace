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
        backGround = SKSpriteNode(texture: SKTexture(imageNamed: GameConstants.BackGround.ImageName))
        backGround.size = CGSize(width: frame.size.width, height: frame.size.height)
        backGround.zPosition = GameConstants.ZPositions.BackGround
        backGround.name = GameConstants.BackGround.Name
        backGround.position = GameConstants.BackGround.Position

        backGroundMaxX = backGround.frame.maxX
        backGroundMaxY = backGround.frame.maxY
        backGroundMinX = backGround.frame.minX
        backGroundMinY = backGround.frame.minY
        backGroundWidth = backGround.size.width
        backGroundHeight = backGround.size.height

        addChild(backGround)
    }
}
