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

    func getPlaceHolders() {
        if let Die1PlaceHolder = gameTable.childNode(withName: "Die1PlaceHolder") as? SKSpriteNode {
            die1PlaceHolder = Die1PlaceHolder
        }

        if let Die2PlaceHolder = gameTable.childNode(withName: "Die2PlaceHolder") as? SKSpriteNode {
            die2PlaceHolder = Die2PlaceHolder
        }

        if let Die3PlaceHolder = gameTable.childNode(withName: "Die3PlaceHolder") as? SKSpriteNode {
            die3PlaceHolder = Die3PlaceHolder
        }

        if let Die4PlaceHolder = gameTable.childNode(withName: "Die4PlaceHolder") as? SKSpriteNode {
            die4PlaceHolder = Die4PlaceHolder
        }

        if let Die5PlaceHolder = gameTable.childNode(withName: "Die5PlaceHolder") as? SKSpriteNode {
            die5PlaceHolder = Die5PlaceHolder
        }

        if let Die6PlaceHolder = gameTable.childNode(withName: "Die6PlaceHolder") as? SKSpriteNode {
            die6PlaceHolder = Die6PlaceHolder
        }
    }

    func setupDice() {
        if let Die1 = gameTable.childNode(withName: "Die1") as? Die {
            die1 = Die1
            //die1.position = die1PlaceHolder.position
        } else {
            print("die1 not found")
        }

        if let Die2 = gameTable.childNode(withName: "Die2") as? Die {
            die2 = Die2
            //die2.position = die2PlaceHolder.position
        } else {
            print("die2 not found")
        }

        if let Die3 = gameTable.childNode(withName: "Die3") as? Die {
            die3 = Die3
            //die3.position = die3PlaceHolder.position
        } else {
            print("die3 not found")
        }

        if let Die4 = gameTable.childNode(withName: "Die4") as? Die {
            die4 = Die4
            //die4.position = die4PlaceHolder.position
        } else {
            print("die4 not found")
        }

        if let Die5 = gameTable.childNode(withName: "Die5") as? Die {
            die5 = Die5
            //die5.position = die5PlaceHolder.position
        } else {
            print("die5 not found")
        }

        if currentGame.numDice == 6 {
            if let Die6 = gameTable.childNode(withName: "Die6") as? Die {
                die6 = Die6
                //die6.position = die6PlaceHolder.position
            } else {
                print("die6 not found")
            }
        }

        die1.dieSide = dieSide1
        die1.texture = GameConstants.Textures.Die1
        die2.dieSide = dieSide2
        die2.texture = GameConstants.Textures.Die2
        die3.dieSide = dieSide3
        die3.texture = GameConstants.Textures.Die3
        die4.dieSide = dieSide4
        die4.texture = GameConstants.Textures.Die4
        die5.dieSide = dieSide5
        die5.texture = GameConstants.Textures.Die5
        die6.dieSide = dieSide6
        die6.texture = GameConstants.Textures.Die6

        diceArray = [die1, die2, die3, die4, die5]

        if currentGame.numDice == 6 {
            diceArray.append(die6)
        } else {
            die6.removeFromParent()
            die6PlaceHolder.removeFromParent()
        }
        currentDiceArray = diceArray
        positionDice()
        //returnDiceToHomePosition()
    }


    func positionDice() {
        for die in currentDiceArray {
            die.physicsBody = nil
            die.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            die.zRotation = 0
            die.size = GameConstants.Sizes.Dice


            switch die.name {
            case "Die1":
                die1.position = die1PlaceHolder.position
            case "Die2":
                die2.position = die2PlaceHolder.position
            case "Die3":
                die3.position = die3PlaceHolder.position
            case "Die4":
                die4.position = die4PlaceHolder.position
            case "Die5":
                die5.position = die5PlaceHolder.position
            case "Die6":
                die6.position = die6PlaceHolder.position
            default:
                break
            }
        }
        resetDiePhysics()
    }

    // MARK: ********** Roll Dice **********

    /*
    func rollDice() {
        if currentDiceArray.isEmpty {
            resetDice()
            currentPlayer.hasScoringDice = false
            /*
            currentDiceArray = diceArray
            */
        }
        resetDiePhysics()
        rollDiceAction()
        getDieSides()
        firstRoll: if currentPlayer.firstRoll {
            //checkForStraight()
           // checkForFullHouse()

            if straight {
                currentScore += 1500
                currentPlayer.currentRollScore += currentScore
                currentScore = 0
                break firstRoll
            } else if fullHouse {
                currentScore += 1500
                currentPlayer.currentRollScore += currentScore
                currentScore = 0
                break firstRoll
            }
        } else {
            evalDice()//(dice: selectedDieArray)
            if currentPlayer.hasScoringDice == false {
                farkle()
            }
        }
        print("currentScore: \(currentScore)")
        print("currentPlayerRollScore: \(currentPlayer.currentRollScore)")

        //currentPlayer.currentRollScore += currentScore
        currentRollScoreLabel.text = String(currentPlayer.currentRollScore)
        //currentScore = 0
        //resetCounters()
    }
    */

    func rollDice() {
        print("\(currentPlayer.name)")
        if currentDiceArray.isEmpty {
            startNewRoll()
        } else {
            //resetDice()
            returnDiceToHomePosition()
            resetCounters()
            getDieSides()
            evalDice()
            //if currentScore == 0 {
                //farkle()
                //return
            //}
        }
        print("current score: \(currentScore)")
        print("current player current roll score: \(currentPlayer.currentRollScore)")
        print("current roll score label: \(currentRollScoreLabel.text!)")
        currentPlayer.currentRollScore += currentScore
        //currentRollScoreLabel.text = String(currentPlayer.currentRollScore)
        //print("Current Roll Score: \(currentPlayer.currentRollScore)")
        currentScore = 0
        //currentPlayer.currentRollScore = 0
    }

    /*
    func getDieSides() {
        dieSidesArray.removeAll()
        var value = Int()
        for die in currentDiceArray {
            value = Int(arc4random_uniform(6) + 1)
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
            print("current Roll: \(die.dieSide!.value), count: \(die.dieSide!.count)")
        }
        for die in currentDiceArray {
            if die.dieSide!.count >= 3 {
                currentPlayer.hasScoringDice = true
            }
        }
        resetCounters()
    }
    */

    func getDieSides() {
        dieSidesArray.removeAll()
        countDice()
        resetScoringCombos()
        var id = 0
        for dieSide in dieSidesArray {
            print("dieSide count: \(dieSide.count)")

            switch dieSide.count {
            case 2:
                pairs += 1
                dieSidesArray[id].count = 0
            case 3:
                threeOAK = true
                dieSidesArray[id].count = 0
            case 4:
                fourOAK = true
                dieSidesArray[id].count = 0
            case 5:
                fiveOAK = true
                dieSidesArray[id].count = 0
            case 6:
                sixOAK = true
                dieSidesArray[id].count = 0
            default:
                break
            }
            id += 1
        }
    }

    func countDice() {
        var value = Int()
        for die in currentDiceArray {
            value = Int(arc4random_uniform(6)+1)
            switch value {
            case 1:
                dieSide1.count += 1
                die.dieSide = dieSide1
                dieSidesArray.append(dieSide1)
            //currentPlayer.hasScoringDice = true
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
            //currentPlayer.hasScoringDice = true
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

    /*
    func evalDice(dice: [Die]) {
        //checkForStraight()
        //checkForPairs()
        checkForLikeDice(dice: dice)
        checkForScoringDice(dice: dice)
        if currentPlayer.hasScoringDice == false {
            farkle()
        }
    }

    func checkForStraight() {
        var dieValues = [Int]()
        for die in currentDiceArray {
            dieValues.append(die.dieSide!.value)
        }
        dieValues = dieValues.sorted()

        if dieValues == [1, 2, 3, 4, 5] || dieValues == [2, 3, 4, 5, 6] || dieValues == [1, 2, 3, 4, 5, 6] {
            currentScore += 1500
            currentPlayer.currentRollScore += currentScore
            currentScore = 0
            straight = true
            print("Straight Found")
        }
    }

    func checkForFullHouse() {
        if pairs == 1 && threeOAK {
            fullHouse = true
            currentScore += 1250
        }
    }

    /*
    func checkForPairs(dice: [Die]) {
        if !currentDiceArray.isEmpty {
            for die in currentDiceArray {
                if die.dieSide!.count == 2 {
                    pairs += 1
                    die.dieSide!.count = 0
                    print("Pair Found")
                }
            }
            if pairs == 3 {
                currentScore += 500
                pairs = 0
                print("3 Pair Found")
            } else if pairs == 1 {
                for die in currentDiceArray {
                    if die.dieSide!.count == 3 {
                        fullHouse = true
                        currentScore += 1250
                        currentPlayer.currentRollScore += currentScore
                        currentScore = 0
                        die.dieSide!.count = 0
                        print("Full House Found")
                    }
                }
            }
        }
    }
    */

    func checkForLikeDice(dice: [Die]) {
        for die in dice {
            //if die.selected {
                switch die.dieSide!.count {
                case 1:
                    if die.dieSide!.value == 1 && !die.counted {
                        currentScore += 100
                        die.counted = true
                        currentPlayer.currentRollScore += currentScore
                        currentScore = 0
                        //scoringDiceArray.append(die)
                        //currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                    } else if die.dieSide!.value == 5 && !die.counted {
                        currentScore += 50
                        die.counted = true
                        currentPlayer.currentRollScore += currentScore
                        currentScore = 0
                        //scoringDiceArray.append(die)
                        //currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                    }
                    break
                case 2:
                    print("pair found")
                    pairs += 1
                    if die.dieSide!.value == 1 && !die.counted {
                        currentScore += 100
                        die.counted = true
                        currentPlayer.currentRollScore += currentScore
                        currentScore = 0
                        //scoringDiceArray.append(die)
                        //currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                    } else if die.dieSide!.value == 5 && !die.counted {
                        currentScore += 50
                        die.counted = true
                        currentPlayer.currentRollScore += currentScore
                        currentScore = 0
                        //scoringDiceArray.append(die)
                        //currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                    }
                    break
                case 3:
                    print("3 of a Kind Found")
                    threeOAKValue = die.dieSide!.value
                    threeOAK = true
                    currentScore += (die.dieSide!.points * 100)
                    die.counted = true
                    currentPlayer.currentRollScore += currentScore
                    currentScore = 0
                    die.dieSide!.count = 0
                    //scoringDiceArray.append(die)
                    //currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                    break
                case 4:
                    print("4 of a Kind Found")
                    fourOAKValue = die.dieSide!.value
                    fourOAK = true
                    die.dieSide!.count = 0
                    currentScore += ((die.dieSide!.points * 100) * 2)
                    die.counted = true
                    currentPlayer.currentRollScore += currentScore
                    currentScore = 0
                    //scoringDiceArray.append(die)
                    //currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                    break
                case 5:
                    print("5 of a Kind Founc")
                    fiveOAKValue = die.dieSide!.value
                    fiveOAK = true
                    die.dieSide!.count = 0
                    currentScore += ((die.dieSide!.points * 100) * 3)
                    die.counted = true
                    currentPlayer.currentRollScore += currentScore
                    currentScore = 0
                    if currentGame.numDice == 5 {
                        //currentDiceArray.removeAll()
                    } else {
                        //scoringDiceArray.append(die)
                        //currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                    }
                    break
                case 6:
                    sixOAKValue = die.dieSide!.value
                    sixOAK = true
                    die.dieSide!.count = 0
                    currentScore += ((die.dieSide!.points * 100) * 4)
                    die.counted = true
                    currentPlayer.currentRollScore += currentScore
                    currentScore = 0
                    //currentDiceArray.removeAll()
                    break
                default:
                    break
                }
            //}
        }
        if pairs == 3 {
            currentScore += 500
            pairs = 0
            print("3 Pair Found")
        } else if pairs == 1 {
            if threeOAK {
                fullHouse = true
                threeOAK = false
                currentScore += 1250
                currentPlayer.currentRollScore += currentScore
                currentScore = 0
                resetDice()
            }
        }
        resetCounters()
    }

    func checkForScoringDice(dice: [Die]) {
        for die in dice {
            //if die.selected {
                switch die.dieSide!.value {
                case 1:
                    if die.dieSide!.value == threeOAKValue || die.dieSide!.value == fourOAKValue || die.dieSide!.value == fiveOAKValue || die.dieSide!.value == sixOAKValue {
                        //scoringDiceArray.append(die)
                        //currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                        break
                    } else {
                        currentScore += 100
                        die.counted = true
                        currentPlayer.currentRollScore += currentScore
                        currentScore = 0
                        currentPlayer.hasScoringDice = true
                        die.dieSide!.count = 0
                        //scoringDiceArray.append(die)
                        //currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                    }
                case 5:
                    if die.dieSide!.value == threeOAKValue || die.dieSide!.value == fourOAKValue || die.dieSide!.value == fiveOAKValue || die.dieSide!.value == sixOAKValue {
                        //scoringDiceArray.append(die)
                        //currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                        break
                    } else {
                        currentScore += 50
                        die.counted = true
                        currentPlayer.currentRollScore += currentScore
                        currentScore = 0
                        currentPlayer.hasScoringDice = true
                        die.dieSide!.count = 0
                        //scoringDiceArray.append(die)
                        //currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                    }
                default:
                    break
                }
            //}
        }
    }
    */

    func evalDice() {
        print("evaluating dice")
        currentPlayer.hasScoringDice = false
        currentScore = 0
        if pairs == 1 {
            if threeOAK == true {
                fullHouse = true
                threeOAK = false
                pairs = 0
                currentPlayer.hasScoringDice = true
            }
        } else if pairs == 3 {
            threePair = true
            currentPlayer.hasScoringDice = true
        }

        if pairs == 0 {
            straight = checkForStraight()
            if straight {
                currentPlayer.hasScoringDice = true
            }
        }

        for dieSide in dieSidesArray {
            if dieSide.value == 1 || dieSide.value == 5 {
                currentPlayer.hasScoringDice = true
            }
        }

        if !currentPlayer.hasScoringDice {
            farkle()
        } else {
            scoreDice()
            currentPlayer.hasScoringDice = false
        }

        //checkForPairs()
        //checkForLikeDice()
        //checkForScoringDice()
        //for die in scoringDiceArray {
            //die.zPosition = GameConstants.ZPositions.Dice - 0.5
        //}
    }

    func scoreDice() {
        if fullHouse {
            print("full house found")
            currentScore += 1250
            fullHouse = false
        } else if straight {
            print("straight found")
            currentScore += 1500
            straight = false
        } else if threePair {
            print("three pair found")
            currentScore += 500
            threePair = false
        } else if threeOAK {
            for die in currentDiceArray {//} where die.dieSide!.count == 3 {

                if die.selected && die.dieSide!.count == 3 {
                    print("three of a kind found")
                    currentScore += (die.dieSide!.points * 100)
                    die.dieSide!.count = 0
                }
            }
        } else if fourOAK {
            for die in currentDiceArray where die.dieSide!.count == 4 {
                if die.selected {
                    print("three of a kind found")
                    currentScore += ((die.dieSide!.points * 100) * 2)
                    die.dieSide!.count = 0
                }
            }
        } else if fiveOAK {
            for die in currentDiceArray where die.dieSide!.count == 5 {
                if die.selected {
                    print("three of a kind found")
                    currentScore += ((die.dieSide!.points * 100) * 3)
                    die.dieSide!.count = 0
                }
            }
        } else if sixOAK {
            for die in currentDiceArray where die.dieSide!.count == 5 {
                if die.selected {
                    print("three of a kind found")
                    currentScore += ((die.dieSide!.points * 100) * 4)
                    die.dieSide!.count = 0
                }
            }
        } else {
            for die in currentDiceArray where die.dieSide!.value == 1 || die.dieSide!.value == 5 {
                if die.dieSide!.value == 1 && !die.counted {
                    print("a 1 found")
                    currentScore += 100
                    die.counted = true
                } else if die.dieSide!.value == 5 && !die.counted {
                    print("a 5 found")
                    currentScore += 50
                    die.counted = true
                }
                die.dieSide!.count = 0
            }
        }
        resetScoringCombos()

/*
        var scoringCombos = [fullHouse, straight, threePair, threeOAK, fourOAK, fiveOAK, sixOAK]
        var id = 0

        for combo in scoringCombos {
            print("current scoring combo: \(combo)")
            switch combo {
            case fullHouse == true:
                print("full house found")
                currentScore += 1250
                scoringCombos[id] = false
            case straight == true:
                print("straight found")
                currentScore += 1500
                scoringCombos[id] = false
            case threePair == true:
                print("three pair found")
                currentScore += 500
                scoringCombos[id] = false
            case threeOAK == true:
                for die in currentDiceArray where die.dieSide!.count == 3 {
                    if die.selected {
                        print("three of a kind found")
                        currentScore += (die.dieSide!.points * 100)
                        die.dieSide!.count = 0
                        scoringCombos[id] = false
                    }
                }
            case fourOAK == true:
                for die in currentDiceArray where die.dieSide!.count == 4 {
                    print("four of a kind found")
                    currentScore += ((die.dieSide!.points * 100) * 2)
                    die.dieSide!.count = 0
                    scoringCombos[id] = false
                }
            case fiveOAK == true:
                for die in currentDiceArray where die.dieSide!.count == 5 {
                    print("five of a kind found")
                    currentScore += ((die.dieSide!.points * 100) * 3)
                    die.dieSide!.count = 0
                    scoringCombos[id] = false
                }
            case sixOAK == true:
                for die in currentDiceArray where die.dieSide!.count == 6 {
                    print("six of a kind found")
                    currentScore += ((die.dieSide!.points * 100) * 4)
                    die.dieSide!.count = 0
                    scoringCombos[id] = false
                }
            default:
                for die in currentDiceArray where die.dieSide!.value == 1 || die.dieSide!.value == 5 {
                    if die.dieSide!.value == 1 && !die.counted {
                        print("a 1 found")
                        currentScore += 100
                        die.counted = true
                    } else if die.dieSide!.value == 5 && !die.counted {
                        print("a 5 found")
                        currentScore += 50
                        die.counted = true
                    }
                    die.dieSide!.count = 0
                }
            }
            id += 1
        }
        resetScoringCombos()
        */

        /*
        if fullHouse {
            currentScore += 1250
        } else if straight {
            currentScore += 1500
        } else if threePair {
            currentScore += 500
        } else {
            for die in currentDiceArray where die.selected && !die.counted {
                if die.dieSide!.value == 1 {
                    currentScore += 100
                    die.counted = true
                } else if die.dieSide!.value == 5 {
                    currentScore += 50
                    die.counted = true
                }
            }

        }
        */
        //currentPlayer.currentRollScore += currentScore
        //currentRollScoreLabel.text = String(currentPlayer.currentRollScore)
    }

    func resetScoringCombos() {
        fullHouse = false
        straight = false
        threePair = false
        threeOAK = false
        fourOAK = false
        fiveOAK = false
        sixOAK = false
    }

    func checkForStraight() -> Bool {
        var dieValues = [Int]()
        var result = Bool()

        for die in currentDiceArray {
            dieValues.append(die.dieSide!.value)
        }
        dieValues = dieValues.sorted()

        if dieValues ==  [1,2,3,4,5] || dieValues == [2,3,4,5,6] || dieValues == [1,2,3,4,5,6] {
            print("straight found")
            //currentScore += 1500
            result = true
            //currentDiceArray.removeAll()
        } else {
            result = false
        }
        return result
    }

    func checkForPairs() {
        if !currentDiceArray.isEmpty {
            for die in currentDiceArray {
                if die.dieSide!.count == 2 {
                    pairs += 1
                    die.dieSide!.count = 0
                } else if die.dieSide!.count == 3 {
                    threeOAK = true
                }
            }
            if pairs == 1 && threeOAK == true {

                //for die in currentDiceArray {
                    //if die.dieSide!.count == 3 {
                        print("full house found")
                        fullHouse = true
                        threeOAK = false
                        currentScore += 1250
                        //die.dieSide!.count = 0
                        currentDiceArray.removeAll()
                    //}
            } else if pairs == 3 {
                print("three pair found")
                currentScore += 500
                currentDiceArray.removeAll()
                pairs = 0
            }
        }
        pairs = 0
    }

    func checkForLikeDice() {
        print("pairs: \(pairs)")

        for die in currentDiceArray {
            if die.selected {
                switch die.dieSide!.count {
                case 1:
                    if die.dieSide!.value == 1 {
                        print("1 found")
                        currentScore += 100
                        scoringDiceArray.append(die)
                        currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                    } else if die.dieSide!.value == 5 {
                        print("5 found")
                        currentScore += 50
                        scoringDiceArray.append(die)
                        currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                    }
                    break
                case 2:
                    if die.dieSide!.value == 1 {
                        print("1 found")
                        currentScore += 100
                        scoringDiceArray.append(die)
                        currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                    } else if die.dieSide!.value == 5 {
                        print("5 found")
                        currentScore += 50
                        scoringDiceArray.append(die)
                        currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                    }
                    break
                case 3:
                    print("three of a kind found")
                    threeOAKValue = die.dieSide!.value
                    threeOAK = true
                    currentScore += (die.dieSide!.points * 100)
                    die.dieSide!.count = 0
                    scoringDiceArray.append(die)
                    currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                case 4:
                    fourOAKValue = die.dieSide!.value
                    print("four of a kind")
                    fourOAK = true
                    die.dieSide!.count = 0
                    currentScore += ((die.dieSide!.points * 100) * 2)
                    scoringDiceArray.append(die)
                    currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                    break
                case 5:
                    fiveOAKValue = die.dieSide!.value
                    print("five of a kind")
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
                    print("six of a kind")
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
    }

    func checkForScoringDice() {
        for die in currentDiceArray {
            if die.selected {
                switch die.dieSide!.value {
                case 1:
                    if die.dieSide!.value == threeOAKValue || die.dieSide!.value == fourOAKValue || die.dieSide!.value == fiveOAKValue || die.dieSide!.value == sixOAKValue {
                        scoringDiceArray.append(die)
                        currentDiceArray.removeAll(where: { $0.dieSide!.value == die.dieSide!.value } )
                        break
                    } else {
                        currentScore += 100
                        print("1 found")
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
                        print("5 found")
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
    }


    func resetCounters() {
        pairs = 0
        for die in currentDiceArray {
            die.counted = false
        }
        dieSide1.count = 0
        dieSide2.count = 0
        dieSide3.count = 0
        dieSide4.count = 0
        dieSide5.count = 0
        dieSide6.count = 0
    }

    func rollDiceAction(die: Die, isComplete: (Bool) -> Void) {
        for die in currentDiceArray {
            //print("dieSelected: \(die.selected)")
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
        }
    }

    func setDieSides(die: Die) {
        die.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
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
        runFarkleAction(isComplete: handlerBlock)
    }

    func returnDiceToHomePosition() {
        let moveDie1 = SKAction.run {
            self.die1.position = self.die1PlaceHolder.position
        }
        let moveDie2 = SKAction.run {
            self.die2.position = self.die2PlaceHolder.position
        }
        let moveDie3 = SKAction.run {
            self.die3.position = self.die3PlaceHolder.position
        }
        let moveDie4 = SKAction.run {
            self.die4.position = self.die4PlaceHolder.position
        }
        let moveDie5 = SKAction.run {
            self.die5.position = self.die5PlaceHolder.position
        }
        let moveDie6 = SKAction.run {
            self.die5.position = self.die5PlaceHolder.position
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
                die.physicsBody?.collisionBitMask = 2
                die.physicsBody?.isDynamic = false
                die.run(rotateDice)
            }
            self.die1.run(moveDie1)
            self.die2.run(moveDie2)
            self.die3.run(moveDie3)
            self.die4.run(moveDie4)
            self.die5.run(moveDie5)
        }

        let moveDice2 = SKAction.run {
            for die in self.currentDiceArray {
                die.physicsBody?.collisionBitMask = 2
                die.physicsBody?.isDynamic = false
                die.run(rotateDice)
            }
            self.die1.run(moveDie1)
            self.die2.run(moveDie2)
            self.die3.run(moveDie3)
            self.die4.run(moveDie4)
            self.die5.run(moveDie5)
            self.die6.run(moveDie6)
        }

        let resetDice = SKAction.run {
            self.resetDieVariables()
        }

        let wait = SKAction.wait(forDuration: 1)

        let seq1 = SKAction.sequence([wait, moveDice1, resetDice])

        let seq2 = SKAction.sequence([wait, moveDice2, resetDice])

        for die in currentDiceArray {
            if currentGame.numDice == 5 {
                die.run(seq1)
            } else {
                die.run(seq2)
            }
        }
    }

    func runFarkleAction(isComplete: (Bool) -> Void) {
        let wait = SKAction.wait(forDuration: 0.5)
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

        let moveDie1 = SKAction.move(to: die1PlaceHolder.position, duration: 0.05)
        let moveDie2 = SKAction.move(to: die2PlaceHolder.position, duration: 0.05)
        let moveDie3 = SKAction.move(to: die3PlaceHolder.position, duration: 0.05)
        let moveDie4 = SKAction.move(to: die4PlaceHolder.position, duration: 0.05)
        let moveDie5 = SKAction.move(to: die5PlaceHolder.position, duration: 0.05)
        let moveDie6 = SKAction.move(to: die6PlaceHolder.position, duration: 0.05)

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

        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        let fadeTo = SKAction.fadeAlpha(to: 0.65, duration: 0.5)

        let seq1 = SKAction.sequence([wait, fadeOut, changeColorToRed, fadeIn, fadeOut, fadeIn, fadeOut, changeColorBack, fadeTo, wait, moveDice1, nextPlayer])

        let seq2 = SKAction.sequence([wait, fadeOut, changeColorToRed, fadeIn, fadeOut, fadeIn, fadeOut, changeColorBack, fadeTo, wait, moveDice2, nextPlayer])

        if currentGame.numDice == 5 {
            logo.run(seq1)
        } else {
            logo.run(seq2)
        }
        isComplete(true)
    }

    func resetDieVariables() {
        for die in currentDiceArray {
            die.dieSide!.count = 0
            die.selected = false
            die.counted = false
        }
   }

    func resetDice() {
        currentDiceArray = diceArray
        for die in currentDiceArray {
            die.dieSide!.count = 0
            die.selected = false
            die.counted = false
        }
        resetDiePhysics()
    }

    func resetDiePhysics() {
        for die in currentDiceArray {
            die.physicsBody = SKPhysicsBody(texture: die.texture!, size: die.size)
            die.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            die.physicsBody?.affectedByGravity = false
            die.physicsBody?.isDynamic = true
            die.physicsBody?.allowsRotation = true
            die.physicsBody?.categoryBitMask = 1
            die.physicsBody?.contactTestBitMask = 1
            die.physicsBody?.collisionBitMask = 1
            die.physicsBody?.restitution = 0.5
            die.physicsBody?.linearDamping = 4
            die.physicsBody?.angularDamping = 5
            die.zPosition = GameConstants.ZPositions.Dice
        }
    }
}
