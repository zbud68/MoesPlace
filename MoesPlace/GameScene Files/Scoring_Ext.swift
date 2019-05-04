//
//  Scoring_Ext.swift
//  MoesPlace
//
//  Created by Mark Davis on 5/3/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

extension GameScene {

    func setupScoringCombosArray() {
        scoringCombosArray = ["Straight":straight, "FullHouse":fullHouse, "ThreeOAK":threeOAK, "FourOAK":fourOAK, "FiveOAK":fiveOAK, "Singles":singles]
        if currentGame.numDice == 6 {
            scoringCombosArray["ThreePair"] = threePair
            scoringCombosArray["SixOAK"] = sixOAK
        }
    }

    func rollDice() {
        currentScore = 0
        currentPlayer.hasScoringDice = false
        resetDiePhysics()
        if currentDiceArray.isEmpty {
            //print("new roll started")
            startNewRoll()
        } else {
            getDieSides()
        }
        displayScore()
        print("current score: \(currentScore)")
        print("current player current roll score: \(currentPlayer.currentRollScore)")
        print("current roll score label: \(currentRollScoreLabel.text!)")
    }

    func countDice(isComplete: (Bool) -> Void) {
        resetDieCount()
        rollDiceAction()
        var value = Int()
        for die in currentDiceArray {
            value = Int(arc4random_uniform(6)+1)
            switch value {
            case 1:
                dieFace1.countThisRoll += 1
                die.dieFace = dieFace1
            case 2:
                dieFace2.countThisRoll += 1
                die.dieFace = dieFace2
            case 3:
                dieFace3.countThisRoll += 1
                die.dieFace = dieFace3
            case 4:
                dieFace4.countThisRoll += 1
                die.dieFace = dieFace4
            case 5:
                dieFace5.countThisRoll += 1
                die.dieFace = dieFace5
            case 6:
                dieFace6.countThisRoll += 1
                die.dieFace = dieFace6
            default:
                break
            }
            dieFacesArray.append(die.dieFace!.faceValue)

            //print("dieValue: \(die.dieFace!.faceValue), dieCount: \(die.dieFace!.countThisRoll)")
        }

        /*
         for die in currentDiceArray {
         if die.dieFace!.faceValue == 1 || die.dieFace!.faceValue == 5 {
         scoringCombosArray["Singles"] = true
         }
         }
         */

        //let uniqueDieFaces = removeDuplicateInts(values: dieFacesArray)
        //print(dieFacesArray)
        //print(uniqueDieFaces)
        //dieFacesArray = uniqueDieFaces
        //print(dieFacesArray)

        isComplete(true)
    }

    func getScoringCombos(isComplete: (Bool) -> Void) {
        for die in currentDiceArray where die.selected {
            let count = die.dieFace!.countThisRoll
            switch count {
            case 1:
                if die.dieFace!.faceValue == 1 || die.dieFace!.faceValue == 5 {
                    currentPlayer.hasScoringDice = true
                    singles = true
                    scoreDice(key: "Singles", isComplete: handlerBlock)
                }
            case 2:
                if die.dieFace!.faceValue == 1 || die.dieFace!.faceValue == 5 {
                    currentPlayer.hasScoringDice = true
                    singles = true
                    scoreDice(key: "Singles", isComplete: handlerBlock)
                }
                pairs += 1
            case 3:
                threeOAK = true
                if pairs == 1 {
                    fullHouse = true
                    threeOAK = false
                    pairs = 0
                    scoreDice(key: "FullHouse", isComplete: handlerBlock)
                } else {
                    threeOAKFaceValue = die.dieFace!.faceValue
                    scoreDice(key: "ThreeOAK", isComplete: handlerBlock)
                    die.dieFace!.countThisRoll = 0
                }
                currentPlayer.hasScoringDice = true
            case 4:
                fourOAK = true
                threeOAKFaceValue = die.dieFace!.faceValue
                currentPlayer.hasScoringDice = true
                scoreDice(key: "FourOAK", isComplete: handlerBlock)
                die.dieFace!.countThisRoll = 0
            case 5:
                fiveOAK = true
                fiveOAKFaceValue = die.dieFace!.faceValue
                currentPlayer.hasScoringDice = true
                scoreDice(key: "FiveOAK", isComplete: handlerBlock)
                die.dieFace!.countThisRoll = 0
            case 6:
                sixOAK = true
                sixOAKFaceValue = die.dieFace!.faceValue
                currentPlayer.hasScoringDice = true
                scoreDice(key: "SixOAK", isComplete: handlerBlock)
                die.dieFace!.countThisRoll = 0
            default:
                break
            }
            print("Die Value: \(die.dieFace!.faceValue), Die Count: \(die.dieFace!.countThisRoll)")
        }
        if pairs == 3 {
            threePair = true
            pairs = 0
            currentPlayer.hasScoringDice = true
            scoreDice(key: "ThreePair", isComplete: handlerBlock)
        }

        currentDiceArray.removeAll(where: { $0.selected })
        isComplete(true)
    }

    func scoreDice(key: String, isComplete: (Bool) -> Void) {
        print("inside scoreDice")
        for combo in scoringCombosArray.keys where combo == key {
            switch combo {
            case "FullHouse":
                print("FullHouse found")
                currentScore = 1250
                positionDice()
                startNewRoll()
            case "Straight":
                print("Straight found")
                currentScore = 1500
                positionDice()
                startNewRoll()
            case "ThreePair":
                currentScore = 500
                pairs = 0
                positionDice()
                startNewRoll()
            case "ThreeOAK":
                print("three of a kind")
                currentScore = calcMultiDieScore(count: 3)
            case "FourOAK":
                print("four of a kind")
                currentScore = calcMultiDieScore(count: 4)
            case "FiveOAK":
                print("five of a kind")
                currentScore = calcMultiDieScore(count: 5)
            case "SixOAK":
                print("six of a kind")
                currentScore = calcMultiDieScore(count: 6)
            case "Singles":
                if currentPlayer.hasScoringDice {
                    currentScore = calcSingleDice()
                } else {
                    farkle()
                }
            default:
                break
            }
            print("hasScoringDice: \(currentPlayer.hasScoringDice)")
            scoreTally.append(currentScore)
        }
        displayScore()
        print("score tally: \(scoreTally)")
        scoreTally.removeAll()
        resetScoringCombosArray()
        isComplete(true)
    }

    func displayScore() {
        currentPlayer.currentRollScore += currentScore
        currentRollScoreLabel.text = String(currentPlayer.currentRollScore)
        currentScore = 0
    }

    func checkForStraight() {
        currentDieValuesArray.removeAll()
        for die in currentDiceArray {
            currentDieValuesArray.append(die.dieFace!.faceValue)
        }
        //currentDieValuesArray = [2,3,5,1,4]
        currentDieValuesArray = currentDieValuesArray.sorted()
        if currentDieValuesArray == [1,2,3,4,5] || currentDieValuesArray == [2,3,4,5,6] || currentDieValuesArray == [1,2,3,4,5,6] {
            straight = true
            currentPlayer.hasScoringDice = true
            currentDieValuesArray.removeAll()
            scoreDice(key: "Straight", isComplete: handlerBlock)
            print("Straight: \(straight)")
        }
    }

    func handleMultipleDieSelection(dieValue: Int, dieCount: Int) {

    }


    func moveDiceCollection(count: Int){
        let moveDie1 = SKAction.move(to: die1PlaceHolder.position, duration: 0.25)
        let moveDie2 = SKAction.move(to: die2PlaceHolder.position, duration: 0.25)
        let moveDie3 = SKAction.move(to: die3PlaceHolder.position, duration: 0.25)
        let moveDie4 = SKAction.move(to: die4PlaceHolder.position, duration: 0.25)
        let moveDie5 = SKAction.move(to: die5PlaceHolder.position, duration: 0.25)
        let moveDie6 = SKAction.move(to: die6PlaceHolder.position, duration: 0.25)

        for die in currentDiceArray where die.dieFace!.countThisRoll == count {
            die.selected = true
            die.counted = true
            die.physicsBody?.collisionBitMask = 2
            die.physicsBody?.isDynamic = false
            die.physicsBody?.allowsRotation = false

            switch die.name {
            case "Die1":
                die.zRotation = 0
                die.run(moveDie1)
            case "Die2":
                die.zRotation = 0
                die.run(moveDie2)
            case "Die3":
                die.zRotation = 0
                die.run(moveDie3)
            case "Die4":
                die.zRotation = 0
                die.run(moveDie4)
            case "Die5":
                die.zRotation = 0
                die.run(moveDie5)
            case "Die6":
                die.zRotation = 0
                die.run(moveDie6)
            default:
                break
            }
        }
        currentDiceArray.removeAll(where: { $0.selected })
    }

    func calcMultiDieScore(count: Int) -> Int {
        print("Calculating Scoring Combo")
        print("count: \(count)")
        var result = 0
        for die in selectedDieArray where die.dieFace!.countThisRoll == count {
            if die.dieFace!.faceValue == 1 {
                result = (1000 * (count - 2))
                //die.dieFace!.countThisRoll = 0
            } else {
                result = ((die.dieFace!.faceValue * 100) * (count - 2))
                //die.dieFace!.countThisRoll = 0
            }
            die.counted = true
        }
        print("result: \(result)")
        return result
    }

    func calcSingleDice() -> Int {
        var result = 0
        for die in currentDiceArray where die.dieFace!.countThisRoll < 3 && die.selected {
            if die.dieFace!.faceValue == 1 {
                result += 100
            } else if die.dieFace!.faceValue == 5 {
                result += 50
            }
            die.counted = true
        }
        return result
    }

    func farkle() {
        runFarkleAction(isComplete: handlerBlock)
    }

    func runFarkleAction(isComplete: (Bool) -> Void) {
        let wait = SKAction.wait(forDuration: 0.25)
        let fadeOut = SKAction.fadeOut(withDuration: 0.25)
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

        let fadeIn = SKAction.fadeIn(withDuration: 0.25)
        let fadeTo = SKAction.fadeAlpha(to: 0.65, duration: 0.25)

        let seq1 = SKAction.sequence([wait, fadeOut, changeColorToRed, fadeIn, fadeOut, fadeIn, fadeOut, changeColorBack, fadeTo, wait, moveDice1, nextPlayer])

        let seq2 = SKAction.sequence([wait, fadeOut, changeColorToRed, fadeIn, fadeOut, fadeIn, fadeOut, changeColorBack, fadeTo, wait, moveDice2, nextPlayer])

        if currentGame.numDice == 5 {
            logo.run(seq1)
        } else {
            logo.run(seq2)
        }
        resetDice()
        isComplete(true)
    }

    func resetScoringCombos() {
        for (key, _) in scoringCombosArray {
            scoringCombosArray[key] = false
        }
    }

    func resetScoringCombosArray() {
        for (key,_) in scoringCombosArray {
            scoringCombosArray[key] = false
        }
    }

    func resetDieCount() {
        for die in currentDiceArray {
            die.dieFace?.countThisRoll = 0
        }
        for die in selectedDieArray {
            die.dieFace?.countThisRoll = 0
        }
    }

    func resetCounters() {
        pairs = 0
        for die in currentDiceArray {
            die.selected = false
            die.counted = false
        }
    }

    func resetDieVariables() {
        for die in currentDiceArray {
            die.selected = false
            die.counted = false
        }
        for die in selectedDieArray {
            die.selected = false
            die.counted = false
        }
    }
}
