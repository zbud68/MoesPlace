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
        resetDice()
        //resetCounters()
        getDieSides()
        evalDice()
        getCurrentRollScore()
        currentScoreLabel.text = String(currentPlayer.currentRollScore)
        print("Current Roll Score: \(currentPlayer.currentRollScore)")
        currentPlayer.currentRollScore = 0
    }

    func getDieSides() {
        var dieSideCount = 0
        dieSidesArray.removeAll()
        for die in currentDiceArray {
            let value = Int(arc4random_uniform(6)+1)

            switch value {
            case 1:
                dieSide1.count += 1
                dieSideCount = dieSide1.count
                die.dieSide = dieSide1
                appendDieSidesArray(dieSide: dieSide1)
                currentPlayer.hasScoringDice = true
            case 2:
                dieSide2.count += 1
                dieSideCount = dieSide2.count
                die.dieSide = dieSide2
                appendDieSidesArray(dieSide: dieSide1)
            case 3:
                dieSide3.count += 1
                dieSideCount = dieSide3.count
                die.dieSide = dieSide3
                appendDieSidesArray(dieSide: dieSide1)
            case 4:
                dieSide4.count += 1
                dieSideCount = dieSide4.count
                die.dieSide = dieSide4
                appendDieSidesArray(dieSide: dieSide1)
            case 5:
                dieSide5.count += 1
                dieSideCount = dieSide5.count
                die.dieSide = dieSide5
                currentPlayer.hasScoringDice = true
                appendDieSidesArray(dieSide: dieSide1)
            case 6:
                dieSide6.count += 1
                dieSideCount = dieSide6.count
                die.dieSide = dieSide6
                appendDieSidesArray(dieSide: dieSide1)
            default:
                break
            }
            die.dieSide!.count = dieSideCount
            dieSideCount = 0
        }
        for die in currentDiceArray {
            print("current Roll: \(die.dieSide!.value), count: \(die.dieSide!.count)")
        }
        for dieSide in dieSidesArray {
            print("curren Die Side: \(dieSide.value), count: \(dieSide.count)")
        }
    }
    
    func appendDieSidesArray(dieSide: DieSide) {
        for currendDieSide in dieSidesArray {
            if dieSide.name != currendDieSide.name {
                dieSidesArray.append(dieSide)
            }
        }
    }
    
    func evalDice() {
        checkForStraight()
        checkForLikeDice()
        checkForScoringDice()
        //resetCounters()
    }
    
    func getCurrentRollScore() {
        if straight {
            print("Straight")
            currentPlayer.currentRollScore += 1500
            currentScoreLabel.text = String(currentPlayer.currentRollScore)
            straight = false
        } else if fullHouse {
            print("full house")
            currentPlayer.currentRollScore += 1250
            currentScoreLabel.text = String(currentPlayer.currentRollScore)
            fullHouse = false
        } else if threePair {
            print("three pair")
            currentPlayer.currentRollScore += 500
            currentScoreLabel.text = String(currentPlayer.currentRollScore)
            threePair = false
        }
        //currentScoreLabel.text = String(currentPlayer.currentRollScore)
    }
    
    func resetCounters() {
        for die in currentDiceArray {
            die.dieSide!.count = 0
            die.dieSide!.counted = false
            die.counted = false
        }
    }

    func checkForStraight() {
        var dieValues = [Int]()
        for die in currentDiceArray {
            dieValues.append(die.dieSide!.value)
        }
        dieValues = dieValues.sorted()
        
        if dieValues ==  [1,2,3,4,5] || dieValues == [2,3,4,5,6] || dieValues == [1,2,3,4,5,6] {
            //currentPlayer.currentRollScore += 1500
            straight = true
            //currentPlayer.hasScoringDice = true
        }
        //resetCounters()
    }
    
    func checkForLikeDice() {
        //countDice()
        //getPairs()

        for die in currentDiceArray {
            switch die.dieSide!.count {
            case 3:
                print("pairs: \(pairs)")
                threeOAKValue = die.dieSide!.value
                if !die.counted {
                    if pairs == 1 {
                        fullHouse = true
                        //pairs = 0
                    } else {
                        print("three OAK")
                        threeOAK = true
                        die.dieSide!.count = 0
                        currentPlayer.currentRollScore += (die.dieSide!.points * 100)
                    }
                    die.counted = true
                }
                break
            case 4:
                fourOAKValue = die.dieSide!.value
                if !die.counted {
                    print("four OAK")
                    fourOAK = true
                    die.dieSide!.count = 0
                    currentPlayer.currentRollScore += ((die.dieSide!.points * 100) * 2)
                }
                die.counted = true
                break
            case 5:
                fiveOAKValue = die.dieSide!.value
                if !die.counted {
                    print("five OAK")
                    fiveOAK = true
                    die.dieSide!.count = 0
                    if currentGame.numDice == 5 {
                        startNewRoll()
                    }
                    currentPlayer.currentRollScore += ((die.dieSide!.points * 100) * 3)
                }
                die.counted = true
                break
            case 6:
                sixOAKValue = die.dieSide!.value
                if !die.counted {
                    print("six OAK")
                    sixOAK = true
                    die.dieSide!.count = 0
                    currentPlayer.currentRollScore += ((die.dieSide!.points * 100) * 4)
                    startNewRoll()
                }
                die.counted = true
                break
            default:
                break
            }
        }
        //currentDie.dieSide!.count = 0
        resetCounters()
    }
    
    /*
    func checkForPairs() {
        for dieSide in dieSidesArray {
            if dieSide.count == 2 {
                pairs += 1
            }
        }
        /*
        for die in currentDiceArray {
            pairs = 0
            if die.dieSide!.count == 2 {
                pairs += 1
                die.dieSide!.count = 0
            }
        }
        */
    }
    */
    
    func checkForScoringDice() {
        for die in currentDiceArray {
            if !die.counted {
                switch die.dieSide!.value {
                case 1:
                    if die.dieSide!.value == threeOAKValue || die.dieSide!.value == fourOAKValue || die.dieSide!.value == fiveOAKValue || die.dieSide!.value == sixOAKValue {
                        break
                    }
                    currentPlayer.currentRollScore += 100
                    currentPlayer.hasScoringDice = true
                    die.counted = true
                    die.dieSide!.count = 0
                case 5:
                    if die.dieSide!.value == threeOAKValue || die.dieSide!.value == fourOAKValue || die.dieSide!.value == fiveOAKValue || die.dieSide!.value == sixOAKValue {
                        break
                    }
                    currentPlayer.currentRollScore += 50
                    currentPlayer.hasScoringDice = true
                    die.counted = true
                    die.dieSide!.count = 0
                default:
                    break
                }
            }
        }
    }
    
    func countDice() {
        for die in currentDiceArray {
            die.dieSide!.count += 1
        }
    }
    
    func getPairs() {
        print("getPairs:")
        print("pairs: \(pairs)")
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
