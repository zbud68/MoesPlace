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

        die2 = Die(texture: SKTexture(imageNamed: "Die2"))
        die2.name = "Die 2"

        die3 = Die(texture: SKTexture(imageNamed: "Die3"))
        die3.name = "Die 3"

        die4 = Die(texture: SKTexture(imageNamed: "Die4"))
        die4.name = "Die 4"

        die5 = Die(texture: SKTexture(imageNamed: "Die5"))
        die5.name = "Die 5"

        die6 = Die(texture: SKTexture(imageNamed: "Die6"))
        die6.name = "Die 6"

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
            dieNode.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Die1"), size: (dieNode.size))
            dieNode.physicsBody?.affectedByGravity = false
            dieNode.physicsBody?.isDynamic = true
            dieNode.physicsBody?.allowsRotation = true
            dieNode.physicsBody?.categoryBitMask = 1
            dieNode.physicsBody?.contactTestBitMask = 1
            dieNode.physicsBody?.collisionBitMask = 1
            dieNode.physicsBody?.restitution = 0.50
            dieNode.physicsBody?.linearDamping = 1.75
            dieNode.physicsBody?.angularDamping = 3
        }
    }

    func positionDice() {
        for dieNode in dice {
            dieNode.zRotation = 0
            dieNode.zPosition = GameConstants.ZPositions.Dice
            switch dieNode.name {
                case "Die 1":
                    dieNode.position = CGPoint(x: ((gameTable.size.width / 2) - (gameTable.size.width / 6)), y: (gameTable.frame.midY + ((dieNode.size.height) * 2.5)))
                    die1.position = (dieNode.position)
                case "Die 2":
                    dieNode.position = CGPoint(x: (die1.position.x), y: (die1.position.y) - 50)
                    die2.position = (dieNode.position)
                case "Die 3":
                    dieNode.position = CGPoint(x: (die2.position.x), y: (die2.position.y) - 50)
                    die3.position = (dieNode.position)
                case "Die 4":
                    dieNode.position = CGPoint(x: (die3.position.x), y: (die3.position.y) - 50)
                    die4.position = (dieNode.position)
                case "Die 5":
                    dieNode.position = CGPoint(x: (die4.position.x), y: (die4.position.y) - 50)
                    die5.position = (dieNode.position)
                case "Die 6":
                    dieNode.position = CGPoint(x: (die5.position.x), y: (die5.position.y) - 50)
                    die6.position = (dieNode.position)
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
       playerState = .Idle

        if let RollAction = SKAction(named: "RollDice") {
            rollAction = RollAction
        }
        let finishRollAction = SKAction.run {
            die.setDieFace()
        }
        let seq = SKAction.sequence([rollAction, finishRollAction])

        let randomX = CGFloat(arc4random_uniform(200) + 200)
        let randomY = CGFloat(arc4random_uniform(200) + 200)

        for dieNode in dice {
            dieNode.physicsBody?.applyForce(CGVector(dx: randomX, dy: randomY))
            dieNode.physicsBody?.applyAngularImpulse(CGFloat(200))
            dieNode.run(seq)
        }
        playerState = .Rolling
    }
}
