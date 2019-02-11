//
//  Dice_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    func addDice() {
        for die in Dice {
            die.zPosition = GameConstants.ZPositions.Dice
            GameTable.addChild(die)
        }
    }
    
    func setupDiceArray() {
        Die1 = SKSpriteNode(imageNamed: "Die1")
        Die1.name = "Die1"
        Dice.append(Die1)
        
        Die2 = SKSpriteNode(imageNamed: "Die2")
        Die2.name = "Die 2"
        Dice.append(Die2)
        
        Die3 = SKSpriteNode(imageNamed: "Die3")
        Die3.name = "Die 3"
        Dice.append(Die3)
        
        Die4 = SKSpriteNode(imageNamed: "Die4")
        Die4.name = "Die 4"
        Dice.append(Die4)
        
        Die5 = SKSpriteNode(imageNamed: "Die5")
        Die5.name = "Die 5"
        Dice.append(Die5)
        
        Die6 = SKSpriteNode(imageNamed: "Die6")
        Die6.name = "Die 6"
        Dice.append(Die6)
    }
}
