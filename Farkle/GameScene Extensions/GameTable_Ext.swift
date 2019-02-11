//
//  GameTable_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    func setupGameTable() {
        GameTable = SKSpriteNode(imageNamed: "WindowPopup")
        GameTable.name = "Game Table"
        GameTable.zPosition = GameConstants.ZPositions.GameTable
        GameTable.size = CGSize(width: BackGround.size.width - 75, height: BackGround.size.height + 20)
        GameTable.position = CGPoint(x: (backGroundMaxX - (GameTable.size.width / 2) + 40), y: 0)
        GameTable.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: CGPoint(x: GameTable.frame.minX, y: GameTable.frame.minY + 50), size: CGSize(width: GameTable.size.width - 175, height: GameTable.size.height - 100)))
        GameTable.physicsBody?.affectedByGravity = false
        GameTable.physicsBody?.allowsRotation = false
        GameTable.physicsBody?.isDynamic = true
        
        GameTable.physicsBody?.categoryBitMask = 1
        GameTable.physicsBody?.collisionBitMask = 1
        GameTable.physicsBody?.contactTestBitMask = 1
        
        gameTableMaxX = GameTable.frame.maxX
        gameTableMaxY = GameTable.frame.maxY
        gameTableMinX = GameTable.frame.minX
        gameTableMinY = GameTable.frame.minY
        gameTableWidth = GameTable.size.width
        gameTableHeight = GameTable.size.height
        
        BackGround.addChild(GameTable)
    }
}
