//
//  Dice_Ext.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    func setupDieSides() {
        dieSidesArray = [dieSide1, dieSide2, dieSide3, dieSide4, dieSide5, dieSide6]
    }

    func setupDice() {
        diceArray = [die1, die2, die3, die4, die5]
        
        die1.name = "Die 1"
        die1.dieSide = dieSide1
        die1.texture = GameConstants.Textures.Die1
        die2.name = "Die 2"
        die2.dieSide = dieSide2
        die2.texture = GameConstants.Textures.Die2
        die3.name = "Die 3"
        die3.dieSide = dieSide3
        die3.texture = GameConstants.Textures.Die3
        die4.name = "Die 4"
        die4.dieSide = dieSide4
        die4.texture = GameConstants.Textures.Die4
        die5.name = "Die 5"
        die5.dieSide = dieSide5
        die5.texture = GameConstants.Textures.Die5
        die6.name = "Die 6"
        die6.dieSide = dieSide6
        die6.texture = GameConstants.Textures.Die6

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
        positionsArray = [diePosition1, diePosition2, diePosition3, diePosition4, diePosition5]
        if currentGame.numDice == 6 {
            positionsArray.append(diePosition6)
        }
        diePositionsArray = positionsArray
    }

    // MARK: ********** Roll Dice **********

    func rollDice() {
        if currentDiceArray.isEmpty {
            startNewRoll()
        } else {
            resetDice()
            resetCounters()
            getDieSides()
            evalDice()
            if currentScore == 0 {
                farkle()
                return
            }
        }
        currentPlayer.currentRollScore += currentScore
        currentScoreLabel.text = String(currentScore)
        print("Current Roll Score: \(currentScore)")
        currentScore = 0
    }

    func getDieSides() {
        dieSidesArray.removeAll()
        var value = Int()

        for die in currentDiceArray {
            value = Int(arc4random_uniform(6)+1)

            switch value {
            case 1:
                dieSide1.count += 1
                die.dieSide = dieSide1
                dieSidesArray.append(dieSide1)
                currentPlayer.hasScoringDice = true
            case 2:
                dieSide2.count += 1
                die.dieSide = dieSide2
                dieSidesArray.append(dieSide2)
            case 3:
                dieSide3.count += 1
                die.dieSide = dieSide3
                dieSidesArray.append(dieSide3)
            case 4:
                dieSide4.count += 1
                die.dieSide = dieSide4
                dieSidesArray.append(dieSide4)
            case 5:
                dieSide5.count += 1
                die.dieSide = dieSide5
                dieSidesArray.append(dieSide5)
                currentPlayer.hasScoringDice = true
            case 6:
                dieSide6.count += 1
                die.dieSide = dieSide6
                dieSidesArray.append(dieSide6)
            default:
                break
            }
            rollDiceAction(die: die, isComplete: handlerBlock)
            print("current Roll: \(die.dieSide!.value), count: \(die.dieSide!.count)")
        }
    }
    
    func evalDice() {
        checkForStraight()
        checkForPairs()
        checkForLikeDice()
        checkForScoringDice()
        for die in scoringDiceArray {
            die.zPosition = GameConstants.ZPositions.Dice - 0.5
        }
    }
    
    func checkForStraight() {
        var dieValues = [Int]()
        for die in currentDiceArray {
            dieValues.append(die.dieSide!.value)
        }
        dieValues = dieValues.sorted()
        
        if dieValues ==  [1,2,3,4,5] || dieValues == [2,3,4,5,6] || dieValues == [1,2,3,4,5,6] {
            currentScore += 1500
            straight = true
            currentDiceArray.removeAll()
        }
    }
    
    func checkForPairs() {
        if !currentDiceArray.isEmpty {
            for die in currentDiceArray {
                if die.dieSide!.count == 2 {
                    pairs += 1
                    die.dieSide!.count = 0
                }
            }
            if pairs == 3 {
                currentScore += 500
                currentDiceArray.removeAll()
                pairs = 0
            } else if pairs == 1 {
                for die in currentDiceArray {
                    if die.dieSide!.count == 3 {
                        fullHouse = true
                        currentScore += 1250
                        die.dieSide!.count = 0
                        currentDiceArray.removeAll()
                    }
                }
            }
        }
    }
    
    func checkForLikeDice() {
        print("pairs: \(pairs)")

        for die in currentDiceArray {
            switch die.dieSide!.count {
            case 1, 2:
                if die.dieSide!.value == 1 {
                    currentScore += 100
                    scoringDiceArray.append(die)
                    currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                } else if die.dieSide!.value == 5 {
                    currentScore += 50
                    scoringDiceArray.append(die)
                    currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                }
                break
            case 3:
                currentScore += (die.dieSide!.points * 100)
                die.dieSide!.count = 0
                scoringDiceArray.append(die)
                currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
            case 4:
                fourOAKValue = die.dieSide!.value
                print("four OAK")
                fourOAK = true
                die.dieSide!.count = 0
                currentScore += ((die.dieSide!.points * 100) * 2)
                scoringDiceArray.append(die)
                currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                break
            case 5:
                fiveOAKValue = die.dieSide!.value
                print("five OAK")
                fiveOAK = true
                die.dieSide!.count = 0
                currentScore += ((die.dieSide!.points * 100) * 3)
                if currentGame.numDice == 5 {
                    currentDiceArray.removeAll()
                } else {
                    scoringDiceArray.append(die)
                    currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                }
                break
            case 6:
                sixOAKValue = die.dieSide!.value
                print("six OAK")
                sixOAK = true
                die.dieSide!.count = 0
                currentScore += ((die.dieSide!.points * 100) * 4)
                currentDiceArray.removeAll()
                break
            default:
                break
            }
        }
        resetCounters()
    }
    
    func checkForScoringDice() {
        for die in currentDiceArray {
            switch die.dieSide!.value {
            case 1:
                if die.dieSide!.value == threeOAKValue || die.dieSide!.value == fourOAKValue || die.dieSide!.value == fiveOAKValue || die.dieSide!.value == sixOAKValue {
                    scoringDiceArray.append(die)
                    currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                    break
                } else {
                    currentScore += 100
                    currentPlayer.hasScoringDice = true
                    die.dieSide!.count = 0
                    scoringDiceArray.append(die)
                    currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                }
            case 5:
                if die.dieSide!.value == threeOAKValue || die.dieSide!.value == fourOAKValue || die.dieSide!.value == fiveOAKValue || die.dieSide!.value == sixOAKValue {
                    scoringDiceArray.append(die)
                    currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                    break
                } else {
                    currentScore += 50
                    currentPlayer.hasScoringDice = true
                    die.dieSide!.count = 0
                    scoringDiceArray.append(die)
                    currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                }
            default:
                break
            }
        }
    }
    
    func resetCounters() {
        pairs = 0
        for die in currentDiceArray {
            die.dieSide!.count = 0
            die.dieSide!.counted = false
        }
    }
    
    func rollDiceAction(die: Die, isComplete: (Bool) -> Void) {
        var rollAction: SKAction = SKAction()
        let Wait = SKAction.wait(forDuration: 0.50)
        
        if let RollAction = SKAction(named: "RollDice") {
            rollAction = RollAction
        }
        
        let MoveAction = SKAction.run {
            let randomX = CGFloat(arc4random_uniform(5) + 5)
            let randomY = CGFloat(arc4random_uniform(2) + 3)
            
            die.physicsBody?.applyImpulse(CGVector(dx: randomX, dy: randomY))
            die.physicsBody?.applyTorque(3)
        }
        let getDieSides = SKAction.run {
            self.setDieSides(die: die)
        }

        let Group = SKAction.group([rollAction, MoveAction])
        
        let Seq = SKAction.sequence([Group, Wait, getDieSides])
        
        die.position = CGPoint(x: 0, y: 0)
        
        die.run(Seq)
        
        isComplete(true)
    }

    func repositionDice(die: Die, isComplete: (Bool) -> Void) {
        if diePositionsArray.isEmpty {
            diePositionsArray = positionsArray
        }

        die.zRotation = 0
        die.zPosition = GameConstants.ZPositions.Dice - 0.5
        die.size = GameConstants.Sizes.Dice
        die.physicsBody?.categoryBitMask = 100
        die.physicsBody?.isDynamic = false
        
        die.position = diePositionsArray.first!
        diePositionsArray.removeFirst()
        
        isComplete(true)
    }
    
    func setDieSides(die: Die) {
        switch die.dieSide!.value {
        case 1:
            die.texture = GameConstants.Textures.Die1
        case 2:
            die.texture = GameConstants.Textures.Die2
        case 3:
            die.texture = GameConstants.Textures.Die3
        case 4:
            die.texture = GameConstants.Textures.Die4
        case 5:
            die.texture = GameConstants.Textures.Die5
        case 6:
            die.texture = GameConstants.Textures.Die6
        default:
            break
        }
    }
    
    func farkle() {
        currentDiceArray = diceArray
        runFarkleAction(isComplete: handlerBlock)
    }
    
    func runFarkleAction(isComplete: (Bool) -> Void) {
        let wait = SKAction.wait(forDuration: 1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let changeColorToRed = SKAction.run {
            self.logo.zPosition = GameConstants.ZPositions.Dice + 0.5
            self.logo.fontColor = UIColor.red
            self.logo2.zPosition = self.logo.zPosition
            self.logo2.fontColor = UIColor.red
        }
        let changeColorBack = SKAction.run {
            self.logo.zPosition = GameConstants.ZPositions.Logo
            self.logo.fontColor = GameConstants.Colors.LogoFont
            self.logo2.fontColor = GameConstants.Colors.LogoFont
            self.logo2.zPosition = GameConstants.ZPositions.Logo
        }

        let moveDie1 = SKAction.move(to: CGPoint(x: -(gameTable.size.width / 7), y: gameTable.frame.minY + 100), duration: 0.25)
        let moveDie2 = SKAction.move(to: CGPoint(x: -(gameTable.size.width / 7) + die2.size.width, y: gameTable.frame.minY + 100), duration: 0.25)
        let moveDie3 = SKAction.move(to: CGPoint(x: -(gameTable.size.width / 7) + (die3.size.width * 2), y: gameTable.frame.minY + 100), duration: 0.25)
        let moveDie4 = SKAction.move(to: CGPoint(x: -(gameTable.size.width / 7) + (die4.size.width * 3), y: gameTable.frame.minY + 100), duration: 0.25)
        let moveDie5 = SKAction.move(to: CGPoint(x: -(gameTable.size.width / 7) + (die5.size.width * 4), y: gameTable.frame.minY + 100), duration: 0.25)
        let moveDie6 = SKAction.move(to: CGPoint(x: -(gameTable.size.width / 7) + (die6.size.width * 5), y: gameTable.frame.minY + 100), duration: 0.25)

        let nextPlayer = SKAction.run {
            self.nextPlayer()
        }

        let rotateDice = SKAction.run {
            self.die1.zRotation = 0
            self.die2.zRotation = 0
            self.die3.zRotation = 0
            self.die4.zRotation = 0
            self.die5.zRotation = 0
            self.die6.zRotation = 0
            for die in self.currentDiceArray {
                die.physicsBody?.allowsRotation = false
            }
        }

        let moveDice1 = SKAction.run {
            for die in self.currentDiceArray {
                die.run(rotateDice)
            }
            self.die1.run(moveDie1)
            self.die2.run(moveDie2)
            self.die3.run(moveDie3)
            self.die4.run(moveDie4)
            self.die5.run(moveDie5)
        }

        let moveDice2 = SKAction.run {
            self.die1.run(moveDie1)
            self.die2.run(moveDie2)
            self.die3.run(moveDie3)
            self.die4.run(moveDie4)
            self.die5.run(moveDie5)
            self.die6.run(moveDie6)
        }

        let resetDice = SKAction.run {
            self.resetDice()
        }

        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        let fadeTo = SKAction.fadeAlpha(to: 0.65, duration: 0.5)

        let seq1 = SKAction.sequence([wait, fadeOut, changeColorToRed, fadeIn, fadeOut, fadeIn, fadeOut, changeColorBack, fadeTo, wait, moveDice1, nextPlayer, resetDice])

        let seq2 = SKAction.sequence([wait, fadeOut, changeColorToRed, fadeIn, fadeOut, fadeIn, fadeOut, changeColorBack, fadeTo, wait, moveDice2, nextPlayer, resetDice])

        if currentGame.numDice == 5 {
            logo.run(seq1)
        } else {
            logo.run(seq2)
        }

        isComplete(true)
    }
    
    func lowerZPosition() {
        for die in currentDiceArray {
            die.zPosition = GameConstants.ZPositions.Logo - 0.5
        }
    }
}
