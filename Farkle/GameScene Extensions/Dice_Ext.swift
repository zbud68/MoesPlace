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
        Die1 = SKSpriteNode(texture: SKTexture(imageNamed: "Die1"))
        Die1.name = "Die 1"
        
        Die2 = SKSpriteNode(texture: SKTexture(imageNamed: "Die2"))
        Die2.name = "Die 2"
        
        Die3 = SKSpriteNode(texture: SKTexture(imageNamed: "Die3"))
        Die3.name = "Die 3"

        Die4 = SKSpriteNode(texture: SKTexture(imageNamed: "Die4"))
        Die4.name = "Die 4"
        
        Die5 = SKSpriteNode(texture: SKTexture(imageNamed: "Die5"))
        Die5.name = "Die 5"
        
        Die6 = SKSpriteNode(texture: SKTexture(imageNamed: "Die6"))
        Die6.name = "Die 6"
        
        setupDiceArray()
        setupDicePhysics()
        positionDice()
        addDice()
    }
    
    func setupDiceArray() {
        Dice = [Die1, Die2, Die3, Die4, Die5, Die6]
    }
    
    func setupDicePhysics() {
        for die in Dice {
            die.physicsBody = SKPhysicsBody(rectangleOf: die.size)
            die.physicsBody?.affectedByGravity = false
            die.physicsBody?.isDynamic = true
            die.physicsBody?.allowsRotation = true
            die.physicsBody?.categoryBitMask = 1
            die.physicsBody?.contactTestBitMask = 1
            die.physicsBody?.collisionBitMask = 1
            die.physicsBody?.restitution = 0.5
            die.physicsBody?.friction = 0
            die.physicsBody?.linearDamping = 1
            die.physicsBody?.angularDamping = 2
        }
    }

    
    func positionDice() {
        for die in Dice {
            die.zRotation = 0
            die.zPosition = GameTable.zPosition + 1
            switch die.name {
            case "Die 1":
                die.position = CGPoint(x: ((GameTable.size.width / 2) - (GameTable.size.width / 6)), y: (GameTable.frame.midY + (die.size.height / 2)) + ((die.size.height * 3) + (die.size.height / 2)))
                Die1.position = die.position
            case "Die 2":
                die.position = CGPoint(x: Die1.position.x, y: Die1.position.y - 30)
                Die2.position = die.position
            case "Die 3":
                die.position = CGPoint(x: Die2.position.x, y: Die2.position.y - 30)
                Die3.position = die.position
            case "Die 4":
                die.position = CGPoint(x: Die3.position.x, y: Die3.position.y - 30)
                Die4.position = die.position
            case "Die 5":
                die.position = CGPoint(x: Die4.position.x, y: Die4.position.y - 30)
                Die5.position = die.position
            case "Die 6":
                die.position = CGPoint(x: Die5.position.x, y: Die5.position.y - 30)
                Die6.position = die.position
            default:
                break
            }
        }
    }
    
    func addDice() {
        for die in Dice {
            GameTable.addChild(die)
        }
    }
    
    func rollDice() {
        if let RollDice = SKAction(named: "RollDice") {
            diceAction = RollDice
        }
        for die in Dice {
            die.run(diceAction)
            die.physicsBody?.applyImpulse(CGVector(dx: 100, dy: 100))
            die.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0))
        }
    }

}
