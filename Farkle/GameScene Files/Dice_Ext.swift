//
//  Dice_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    func setupDieFaces() {
        dieFaceArray = [dieFace1, dieFace2, dieFace3, dieFace4, dieFace5, dieFace6]
    }

    func setupDice() {
        diceArray = [die1, die2, die3, die4, die5]
        
        die1.name = "Die 1"
        die2.name = "Die 2"
        die3.name = "Die 3"
        die4.name = "Die 4"
        die5.name = "Die 5"
        die6.name = "Die 6"
        
        if currentGame.numDice == 6 {
            diceArray.append(die6)
        }
        currentDiceArray = diceArray

        for die in currentDiceArray {
            die.selected = false
            die.selectable = true

            die.physicsBody = SKPhysicsBody(rectangleOf: GameConstants.Sizes.Dice)
            die.physicsBody?.affectedByGravity = false
            die.physicsBody?.isDynamic = true
            die.physicsBody?.allowsRotation = true
            die.physicsBody?.categoryBitMask = 1
            die.physicsBody?.contactTestBitMask = 1
            die.physicsBody?.collisionBitMask = 1
            die.physicsBody?.restitution = 0.5
            die.physicsBody?.linearDamping = 4
            die.physicsBody?.angularDamping = 5
            gameTable.addChild(die)
            positionDice(die: die)
        }
        reducedPositionArray = diePositionsArray
    }
    
    func positionDice(die: Die) {
        die.zRotation = 0
        die.zPosition = GameConstants.ZPositions.Dice
        die.size = GameConstants.Sizes.Dice

        switch die.name {
        case "Die 1":
            diePosition1 = CGPoint(x: -(gameTable.size.width / 7), y: gameTable.frame.minY + 100)
            die1.position = diePosition1
        case "Die 2":
            diePosition2 = CGPoint(x: die1.position.x + die2.size.width, y: gameTable.frame.minY + 100)
            die2.position = diePosition2
        case "Die 3":
            diePosition3 = CGPoint(x: die2.position.x + die3.size.width, y: gameTable.frame.minY + 100)
            die3.position = diePosition3
        case "Die 4":
            diePosition4 = CGPoint(x: die3.position.x + die4.size.width, y: gameTable.frame.minY + 100)
            die4.position = diePosition4
        case "Die 5":
            diePosition5 = CGPoint(x: die4.position.x + die5.size.width, y: gameTable.frame.minY + 100)
            die5.position = diePosition5
        case "Die 6":
            diePosition6 = CGPoint(x: die5.position.x + die6.size.width, y: gameTable.frame.minY + 100)
            die6.position = diePosition6
        default:
            break
        }
        diePositionsArray.append(die.position)
        reducedPositionArray.append(die.position)
    }

    // MARK: ********** Roll Dice **********

    func rollDice() {
        if currentPlayer.firstRoll {
            positionID = 0
            currentPlayer.firstRoll = false
        }

        for die in currentDiceArray where die.selected == false {
            rollDiceAction(die: die, isComplete: handlerBlock)
        }
        getFaceValues()
        checkForStraight()
        currentDieValuesArray.removeAll()
    }

    func getFaceValues() {
        for die in currentDiceArray where die.selected == false {
            die.currentValue = Int(arc4random_uniform(6) + 1)
            dieFaceArray?[die.currentValue - 1].value = die.currentValue
            currentDieValuesArray.append(die.currentValue)
        }
        currentDieValuesArray = currentDieValuesArray.sorted()
    }
    
    func checkForStraight() {
        currentDieValuesArray = [1,2,3,4,5]
        if currentDieValuesArray == [1,2,3,4,5] || currentDieValuesArray == [2,3,4,5,6] || currentDieValuesArray == [1,2,3,4,5,6] {
            print("straight")
            currentScore += 1500
            calcCurrentScore()
            startNewRoll()
        }
    }

    func rollDiceAction(die: Die, isComplete: (Bool) -> Void) {
        let Wait = SKAction.wait(forDuration: 0.75)
        if let RollAction = SKAction(named: "RollDice") {
            rollAction = RollAction
        }
        let MoveAction = SKAction.run {
            let _ = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0)
            let randomX = CGFloat(arc4random_uniform(5) + 5)
            let randomY = CGFloat(arc4random_uniform(2) + 3)
            die.physicsBody?.applyImpulse(CGVector(dx: randomX, dy: randomY))
            die.physicsBody?.applyTorque(3)
        }
        let FadeOut = SKAction.fadeAlpha(to: 0, duration: 0.25)
        let FadeIn = SKAction.fadeAlpha(to: 1, duration: 0.25)
        let getDieFaces = SKAction.run {
            self.setDieFaces()
        }
        let Group = SKAction.group([rollAction, MoveAction])
        let Seq = SKAction.sequence([Group, Wait, FadeOut, getDieFaces, FadeIn])
        die.run(Seq)
        isComplete(true)
    }

    func repositionDice(die: Die) {
        die.zRotation = 0
        die.zPosition = GameConstants.ZPositions.Dice - 0.5
        die.size = GameConstants.Sizes.Dice
        die.physicsBody?.categoryBitMask = 100

        //positionID = getPositionID()

        
        die.position = diePositionsArray[getPositionID()]
        /*
        switch die.name {
        case "Die 1":
            die.position = diePosition1
        case "Die 2":
            die.position = diePosition2
        case "Die 3":
            die.position = diePosition3
        case "Die 4":
            die.position = diePosition4
        case "Die 5":
            die.position = diePosition5
        case "Die 6":
            die.position = diePosition6
        default:
            break
        }
        */
    }
    
    func getPositionID() -> Int {
        if positionID >= currentGame.numDice {
            positionID = 0
        } else {
            positionID += 1
        }
        return positionID
    }

    func setDieFaces() {
        for die in currentDiceArray {
            die.texture = dieFaceArray?[die.currentValue - 1].texture
        }
    }
}
