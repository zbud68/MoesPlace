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
            die.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Die1"), size: die.size)
            die.physicsBody?.affectedByGravity = false
            die.physicsBody?.isDynamic = true
            die.physicsBody?.allowsRotation = true
            die.physicsBody?.categoryBitMask = 1
            die.physicsBody?.contactTestBitMask = 1
            die.physicsBody?.collisionBitMask = 1
            die.physicsBody?.restitution = 0.50
            die.physicsBody?.linearDamping = 1.75
            die.physicsBody?.angularDamping = 3
        }
    }

    
    func positionDice() {
        for die in Dice {
            die.zRotation = 0
            die.zPosition = GameTable.zPosition + 1
            switch die.name {
            case "Die 1":
                die.position = CGPoint(x: ((GameTable.size.width / 2) - (GameTable.size.width / 6)), y: (GameTable.frame.midY + (die.size.height * 2.5)))
                Die1.position = die.position
                dieStartPosition = die.position
            case "Die 2":
                die.position = CGPoint(x: Die1.position.x, y: Die1.position.y - 50)
                Die2.position = die.position
            case "Die 3":
                die.position = CGPoint(x: Die2.position.x, y: Die2.position.y - 50)
                Die3.position = die.position
            case "Die 4":
                die.position = CGPoint(x: Die3.position.x, y: Die3.position.y - 50)
                Die4.position = die.position
            case "Die 5":
                die.position = CGPoint(x: Die4.position.x, y: Die4.position.y - 50)
                Die5.position = die.position
            case "Die 6":
                die.position = CGPoint(x: Die5.position.x, y: Die5.position.y - 50)
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
        if let rollAction = SKAction(named: "RollDice") {
            self.rollAction = rollAction
        }
        let finishRollAction = SKAction.run {
            self.setDieFace()
        }
        let seq = SKAction.sequence([rollAction, finishRollAction])
        
        let randomX = CGFloat(arc4random_uniform(200) + 200)
        let randomY = CGFloat(arc4random_uniform(200) + 200)
 
        for die in Dice {
            if die == Die6 {
                die.run(seq)
            } else {
                die.run(rollAction)
            }
            die.physicsBody?.applyForce(CGVector(dx: randomX, dy: randomY))
            die.physicsBody?.applyAngularImpulse(CGFloat(200))
        }

        /*
        for die in Dice {
            while die.physicsBody?.isResting != true {
                diceAreResting = false
            }
            diceAreResting = true
        }
        */
    }

    func setDieFace() {
        rollResults.removeAll()
        for _ in 0...5 {
            let dieValue = Int(arc4random_uniform(6)) + 1
            rollResults.append(dieValue)
        }

        id = 0
        for _ in rollResults {
            switch rollResults[id] {
            case 1:
                Dice[id].texture = SKTexture(imageNamed: "Die1")
                print(rollResults[id]!)
            case 2:
                Dice[id].texture = SKTexture(imageNamed: "Die2")
                print(rollResults[id]!)
            case 3:
                Dice[id].texture = SKTexture(imageNamed: "Die3")
                print(rollResults[id]!)
            case 4:
                Dice[id].texture = SKTexture(imageNamed: "Die4")
                print(rollResults[id]!)
            case 5:
                Dice[id].texture = SKTexture(imageNamed: "Die5")
                print(rollResults[id]!)
            case 6:
                Dice[id].texture = SKTexture(imageNamed: "Die6")
                print(rollResults[id]!)
            default:
                break
            }
            id += 1
        }
    }
}
