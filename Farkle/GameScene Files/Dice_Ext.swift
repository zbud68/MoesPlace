//
//  Dice_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    func setupDice() {
        die1 = Die(texture: SKTexture(imageNamed: "Die1"))
        die1.name = "Die 1"
        die1.size = CGSize(width: 32, height: 32)

        die2 = Die(texture: SKTexture(imageNamed: "Die2"))
        die2.name = "Die 2"
        die2.size = CGSize(width: 32, height: 32)

        die3 = Die(texture: SKTexture(imageNamed: "Die3"))
        die3.name = "Die 3"
        die3.size = CGSize(width: 32, height: 32)

        die4 = Die(texture: SKTexture(imageNamed: "Die4"))
        die4.name = "Die 4"
        die4.size = CGSize(width: 32, height: 32)

        die5 = Die(texture: SKTexture(imageNamed: "Die5"))
        die5.name = "Die 5"
        die5.size = CGSize(width: 64, height: 64)

        die6 = Die(texture: SKTexture(imageNamed: "Die6"))
        die6.name = "Die 6"
        die6.size = CGSize(width: 64, height: 64)

        setupDiceArray()
        setupDicePhysics()
        positionDice()
        addDice()
    }

    func setupDiceArray() {
        dice = [die1, die2, die3, die4, die5, die6]
    }

    func setupDicePhysics() {
        for dieNode in dice {
            dieNode.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Die1"), size: (CGSize(width: 32, height: 32)))
            dieNode.physicsBody?.affectedByGravity = false
            dieNode.physicsBody?.isDynamic = true
            dieNode.physicsBody?.allowsRotation = true
            dieNode.physicsBody?.categoryBitMask = 1
            dieNode.physicsBody?.contactTestBitMask = 1
            dieNode.physicsBody?.collisionBitMask = 1
            dieNode.physicsBody?.restitution = 0.5
            dieNode.physicsBody?.linearDamping = 4
            dieNode.physicsBody?.angularDamping = 5
        }
    }

    func positionDice() {
        for dieNode in dice {
            dieNode.zRotation = 0
            dieNode.zPosition = GameConstants.ZPositions.Dice
            dieNode.size = CGSize(width: 32, height: 32)
            switch dieNode.name {
                
            case "Die 1":
                dieNode.position = CGPoint(x: -(gameTable.size.width / 7), y: gameTable.frame.minY + 100)
                die1.position = dieNode.position
            case "Die 2":
                dieNode.position = CGPoint(x: die1.position.x + dieNode.size.width, y: gameTable.frame.minY + 100)
                die2.position = dieNode.position
            case "Die 3":
                dieNode.position = CGPoint(x: die2.position.x + dieNode.size.width, y: gameTable.frame.minY + 100)
                die3.position = dieNode.position
            case "Die 4":
                dieNode.position = CGPoint(x: die3.position.x + dieNode.size.width, y: gameTable.frame.minY + 100)
                die4.position = dieNode.position
            case "Die 5":
                dieNode.position = CGPoint(x: die4.position.x + dieNode.size.width, y: gameTable.frame.minY + 100)
                die5.position = dieNode.position
            case "Die 6":
                dieNode.position = CGPoint(x: die5.position.x + dieNode.size.width, y: gameTable.frame.minY + 100)
                die6.position = dieNode.position
            default:
                break
            }
        }
    }

    func addDice() {
        for dieNode in dice {
            gameTable.addChild(dieNode)
        }
    }

    func rollDice() {
        playerState = .Rolling

        if let RollAction = SKAction(named: "RollDice") {
            rollAction = RollAction
        }
        let finishRollAction = SKAction.run {
            die.setDieFace()
        }
        let seq = SKAction.sequence([rollAction, finishRollAction])

        let randomX = CGFloat(arc4random_uniform(5) + 5)
        let randomY = CGFloat(arc4random_uniform(2) + 3)

        for dieNode in dice {
            dieNode.physicsBody?.applyImpulse(CGVector(dx: randomX, dy: randomY))
            dieNode.physicsBody?.applyTorque(3)
            dieNode.run(seq)
        }
    }
}
