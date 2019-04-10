//
//  GameTable_Ext.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
        
    func setupGameTable() {
        gameTable = SKSpriteNode(imageNamed: "WindowPopup")
        gameTable.name = "Game Table"
        gameTable.zPosition = GameConstants.ZPositions.GameTable
        gameTable.size = CGSize(width: backGround.size.width - 75, height: backGround.size.height + 20)
        gameTable.position = CGPoint(x: (backGround.frame.maxX - (gameTable.size.width / 2) + 40), y: 0)
        gameTable.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: CGPoint(x: gameTable.frame.minX - 15, y: gameTable.frame.minY + 40), size: CGSize(width: gameTable.size.width - 140, height: gameTable.size.height - 80)))
        gameTable.physicsBody?.affectedByGravity = false
        gameTable.physicsBody?.allowsRotation = false
        gameTable.physicsBody?.isDynamic = true
        gameTable.physicsBody?.restitution = 0.75

        gameTable.physicsBody?.categoryBitMask = 1
        gameTable.physicsBody?.collisionBitMask = 1
        gameTable.physicsBody?.contactTestBitMask = 1

        backGround.addChild(gameTable)
    }
    
    func setupLogo() {
        
        logo.fontName = GameConstants.StringConstants.FontName
        logo.fontColor = GameConstants.Colors.LogoFont
        logo.fontSize = GameConstants.Sizes.Logo1Font
        logo.alpha = 0.65
        logo.position = CGPoint(x: 0, y: -50)
        logo.zPosition = GameConstants.ZPositions.Logo
        
        logo2.fontName = GameConstants.StringConstants.FontName
        logo2.fontColor = GameConstants.Colors.LogoFont
        logo2.fontSize = GameConstants.Sizes.Logo2Font
        logo2.alpha = 0.65
        logo2.zRotation = 75
        
        logo2.zPosition = GameConstants.ZPositions.Logo
        logo2.position = CGPoint(x: -185, y: -25)
        gameTable.addChild(logo)
        logo.addChild(logo2)
    }
    
    func setupCurrentRollScoreLabel() {
        playerNameLabel.text = "\(currentPlayer.name):"
        playerNameLabel.fontName = GameConstants.StringConstants.FontName
        playerNameLabel.fontColor = GameConstants.Colors.LogoFont
        playerNameLabel.fontSize = GameConstants.Sizes.PlayerNameLabelFont
        playerNameLabel.position = CGPoint(x: gameTable.frame.minX + (gameTable.size.width / 3), y: gameTable.frame.maxY / 2)
        playerNameLabel.zPosition = GameConstants.ZPositions.Logo
        playerNameLabel.alpha = 0.65
        
        currentScoreLabel.text = String(currentPlayer.currentRollScore)
        currentScoreLabel.fontName = GameConstants.StringConstants.FontName
        currentScoreLabel.fontColor = GameConstants.Colors.LogoFont
        currentScoreLabel.fontSize = GameConstants.Sizes.PlayerScoreLabelFont
        currentScoreLabel.position = CGPoint(x: playerNameLabel.position.x + 110, y: playerNameLabel.position.y)
        currentScoreLabel.zPosition = GameConstants.ZPositions.Logo
        currentScoreLabel.alpha = 0.65
        
        gameTable.addChild(currentScoreLabel)
        gameTable.addChild(playerNameLabel)
    }
}
