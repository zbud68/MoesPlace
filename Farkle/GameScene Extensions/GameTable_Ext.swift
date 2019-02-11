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
        //self.GameTable = gameTable
        GameTable.name = "Game Table"
        GameTable.zPosition = GameConstants.ZPositions.GameTable
        GameTable.size = CGSize(width: BackGround.size.width - 75, height: BackGround.size.height + 20)
        GameTable.position = CGPoint(x: (backGroundMaxX - (GameTable.size.width / 2) + 40), y: 0)
        GameTable.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: CGPoint(x: 0, y: 0), size: GameTable.size))
        GameTable.physicsBody?.affectedByGravity = GameConstants.GameTable.Gravity
        GameTable.physicsBody?.allowsRotation = GameConstants.GameTable.AllowsRotation
        GameTable.physicsBody?.isDynamic = GameConstants.GameTable.Dynamic
        
        gameTableMaxX = GameTable.frame.maxX
        gameTableMaxY = GameTable.frame.maxY
        gameTableMinX = GameTable.frame.minX
        gameTableMinY = GameTable.frame.minY

        BackGround.addChild(GameTable)
    }
}
