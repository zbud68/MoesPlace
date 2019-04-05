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
        die2.name = "Die 2"
        die2.dieSide = dieSide2
        die3.name = "Die 3"
        die3.dieSide = dieSide3
        die4.name = "Die 4"
        die4.dieSide = dieSide4
        die5.name = "Die 5"
        die5.dieSide = dieSide5
        die6.name = "Die 6"
        die6.dieSide = dieSide6
        
        if currentGame.numDice == 6 {
            diceArray.append(die6)
        }
        currentDiceArray = diceArray

        var id = 0
        for die in currentDiceArray {
            die.dieID = id
            id += 1
            
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
            //gameTable.addChild(die)
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
        getDieSides()
        calcDieRoll()
        if !currentPlayer.hasScoringDice {
            print("Farkle")
            nextPlayer()
        }
        if straight {
            startNewRoll()
        } else if fullHouse {
            startNewRoll()
        } else if threePair {
            startNewRoll()
        } else if currentGame.numDice == 5 {
            if fiveOAK {
                startNewRoll()
            }
        } else if currentGame.numDice == 6 {
            if sixOAK {
                startNewRoll()
            }
        } else {
            resetDice()
        }
    }
    
    func removeCountedDice() -> Bool {
        for _ in currentDiceArray {
            if currentDiceArray.isEmpty {
                currentDiceArray = diceArray
            } else {
                currentDiceArray.removeAll(where: { $0.counted == true })
            }
        }
        return currentPlayer.hasScoringDice
    }
    
    func getDieSides() {
        var dieSideCount = 0
        for die in currentDiceArray {
            let value = Int(arc4random_uniform(6)+1)

            switch value {
            case 1:
                dieSide1.count += 1
                dieSideCount = dieSide1.count
                die.dieSide = dieSide1
                currentPlayer.hasScoringDice = true
            case 2:
                dieSide2.count += 1
                dieSideCount = dieSide2.count
                die.dieSide = dieSide2
            case 3:
                dieSide3.count += 1
                dieSideCount = dieSide3.count
                die.dieSide = dieSide3
            case 4:
                dieSide4.count += 1
                dieSideCount = dieSide4.count
                die.dieSide = dieSide4
            case 5:
                dieSide5.count += 1
                dieSideCount = dieSide5.count
                die.dieSide = dieSide5
                currentPlayer.hasScoringDice = true
            case 6:
                dieSide6.count += 1
                dieSideCount = dieSide6.count
                die.dieSide = dieSide6
            default:
                break
            }
            die.dieSide!.count = dieSideCount
            dieSideCount = 0
        }
        for die in currentDiceArray {
            print("current Roll: \(die.dieSide!.value), count: \(die.dieSide!.count)")
        }
    }
    
    func calcDieRoll() {
        currentPlayer.hasScoringDice = checkForStraight()
        currentPlayer.hasScoringDice = checkForPairs()
        currentPlayer.hasScoringDice = checkForLikeDice()
        //currentPlayer.hasScoringDice = checkForPairs(currentDie: die)
        //currentPlayer.hasScoringDice = checkForFullHouse()
        currentPlayer.hasScoringDice = checkForScoringDice()
        
        if currentDiceArray.isEmpty {
            currentDiceArray.removeAll()
            currentDiceArray = diceArray
        } else {
            for die in currentDiceArray {
                die.dieSide!.count = 0
                die.counted = false
            }
        }
        showScoreTotal()
    }

    func checkForStraight() -> Bool {
        var dieValues = [Int]()
        for die in currentDiceArray where !die.counted {
            dieValues.append(die.dieSide!.value)
        }
        dieValues = dieValues.sorted()
        
        if dieValues ==  [1,2,3,4,5] || dieValues == [2,3,4,5,6] || dieValues == [1,2,3,4,5,6] {
            currentPlayer.currentRollScore += 1500
            straight = true
            currentPlayer.hasScoringDice = true
        }
        if straight {
            for die in currentDiceArray {
                die.counted = true
                straight = false
            }
        }
        return currentPlayer.hasScoringDice
    }
    
    func checkForLikeDice() -> Bool {
        var value = 0
        threeOAK = false
        for die in currentDiceArray {
            let currentDie = die
            if currentDie.dieSide!.count == 3 {
                value = currentDie.dieSide!.value
                if pairs != 1 {
                    threeOAK = true
                } else {
                    currentPlayer.currentRollScore += 750
                    fullHouse = true
                }
            
                for die in currentDiceArray {
                    if die.dieSide!.value == currentDie.dieSide!.value {
                        die.dieSide!.count = 0
                        die.counted = true
                    } else {
                        if die.dieSide!.count == 2 {
                            die.dieSide!.count = 0
                        }
                    }
                }
                currentPlayer.hasScoringDice = true
            }
        }
        for die in currentDiceArray {
            if die.dieSide!.count == 4 {
                if !die.counted {
                    currentPlayer.currentRollScore += (die.dieSide!.points * 100) * 2
                    die.counted = true
                    die.dieSide!.count = 0
                }
                fourOAK = true
                currentPlayer.hasScoringDice = true
            }
        }
        for die in currentDiceArray {
            if die.dieSide!.count == 5 {
                if !die.dieSide!.counted {
                    currentPlayer.currentRollScore += (die.dieSide!.points * 100) * 3
                    die.counted = true
                    die.dieSide!.count = 0
                }
                fiveOAK = true
                currentPlayer.hasScoringDice = true
            }
        }
        for die in currentDiceArray {
            if die.dieSide!.count == 6 {
                if !die.counted {
                    currentPlayer.currentRollScore += (die.dieSide!.points * 100) * 4
                    die.counted = true
                    die.dieSide!.count = 0
                }
                sixOAK = true
                currentPlayer.hasScoringDice = true
            }
        }
        return currentPlayer.hasScoringDice
    }
    
    func checkForPairs() -> Bool {
        for die in currentDiceArray {
            pairs = 0
            if die.dieSide!.count == 2 {
                pairs += 1
            }
        }
        if pairs > 0 || threeOAK == true {
            print("3oak: \(threeOAK)")
            print("pairs: \(pairs)")
        }

        if pairs == 3 {
            currentPlayer.currentRollScore += 500
            currentPlayer.hasScoringDice = true
            startNewRoll()
        }
        return currentPlayer.hasScoringDice
    }
    
    func checkForFullHouse() -> Bool {
        if threeOAK == true && pairs == 1 {
            currentPlayer.currentRollScore += 750
            threeOAK = false
            fullHouse = true
            currentPlayer.hasScoringDice = true
        }
        for die in currentDiceArray where die.dieSide!.count == 2 {
            die.counted = true
        }
        return currentPlayer.hasScoringDice
    }
    
    func checkForScoringDice() -> Bool {
        for die in currentDiceArray {
            if !die.counted {
                switch die.dieSide!.value {
                case 1:
                    currentPlayer.currentRollScore += 100
                    currentPlayer.hasScoringDice = true
                    die.counted = true
                    die.dieSide!.count = 0
                case 5:
                    currentPlayer.currentRollScore += 50
                    currentPlayer.hasScoringDice = true
                    die.counted = true
                    die.dieSide!.count = 0
                default:
                    break
                }
            }
        }
        return currentPlayer.hasScoringDice
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
        let getDieSides = SKAction.run {
            self.setDieSides()
        }
        let Group = SKAction.group([rollAction, MoveAction])
        let Seq = SKAction.sequence([Group, Wait, FadeOut, getDieSides, FadeIn])
        die.run(Seq)
        isComplete(true)
    }

    func repositionDice(die: Die) {
        die.zRotation = 0
        die.zPosition = GameConstants.ZPositions.Dice - 0.5
        die.size = GameConstants.Sizes.Dice
        die.physicsBody?.categoryBitMask = 100

        die.position = diePositionsArray[getPositionID()]
    }
    
    func getPositionID() -> Int {
        if positionID >= currentGame.numDice {
            positionID = 0
        } else {
            positionID += 1
        }
        return positionID
    }

    func setDieSides() {
        for die in currentDiceArray {
            die.texture = dieSidesArray[die.dieSide!.value - 1].texture
        }
    }
}
