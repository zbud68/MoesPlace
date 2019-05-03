//
//  Dice_Ext.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    func setupDieFacesArray() {
        dieFacesArray = [dieFace1.faceValue, dieFace2.faceValue, dieFace3.faceValue, dieFace4.faceValue, dieFace5.faceValue, dieFace6.faceValue]
    }

    func setupScoringCombosArray() {
        scoringCombosArray = ["Straight":straight, "FullHouse":fullHouse, "ThreeOAK":threeOAK, "FourOAK":fourOAK, "FiveOAK":fiveOAK, "Singles":singles]
        if currentGame.numDice == 6 {
            scoringCombosArray["ThreePair"] = threePair
            scoringCombosArray["SixOAK"] = sixOAK
        }
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
        } else {
            print("die1 not found")
        }

        if let Die2 = gameTable.childNode(withName: "Die2") as? Die {
            die2 = Die2
        } else {
            print("die2 not found")
        }

        if let Die3 = gameTable.childNode(withName: "Die3") as? Die {
            die3 = Die3
        } else {
            print("die3 not found")
        }

        if let Die4 = gameTable.childNode(withName: "Die4") as? Die {
            die4 = Die4
        } else {
            print("die4 not found")
        }

        if let Die5 = gameTable.childNode(withName: "Die5") as? Die {
            die5 = Die5
        } else {
            print("die5 not found")
        }

        if currentGame.numDice == 6 {
            if let Die6 = gameTable.childNode(withName: "Die6") as? Die {
                die6 = Die6
            } else {
                print("die6 not found")
            }
        }

        die1.texture = GameConstants.Textures.Die1
        die2.texture = GameConstants.Textures.Die2
        die3.texture = GameConstants.Textures.Die3
        die4.texture = GameConstants.Textures.Die4
        die5.texture = GameConstants.Textures.Die5
        die6.texture = GameConstants.Textures.Die6

        die1.dieFace = dieFace1
        die2.dieFace = dieFace2
        die3.dieFace = dieFace3
        die4.dieFace = dieFace4
        die5.dieFace = dieFace5
        die6.dieFace = dieFace6

        diceArray = [die1, die2, die3, die4, die5]

        if currentGame.numDice == 6 {
            diceArray.append(die6)
        } else {
            die6.removeFromParent()
            die6PlaceHolder.removeFromParent()
        }
        currentDiceArray = diceArray
        positionDice()
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

    func getDieSides() {
        resetCounters()
        resetScoringCombos()
        dieFacesArray.removeAll()
        countDice(isComplete: handlerBlock)
        if currentPlayer.firstRoll {
            getScoringCombos(isComplete: handlerBlock)
        }

        //print("pairs: \(pairs)")
        var id = 0
        for _ in currentDieValuesArray {
            currentDieValuesArray[id] = 0
            id += 1
        }
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

        for die in currentDiceArray {
            if die.dieFace!.faceValue == 1 || die.dieFace!.faceValue == 5 {
                scoringCombosArray["Singles"] = true
            }
        }

        let uniqueDieFaces = removeDuplicateInts(values: dieFacesArray)
        print(dieFacesArray)
        //print(uniqueDieFaces)
        dieFacesArray = uniqueDieFaces
        //print(dieFacesArray)

        isComplete(true)
    }

    func getScoringCombos(isComplete: (Bool) -> Void) {
        var count = 0
        //var value = 0

        for die in currentDiceArray where die.selected {
            //print("dieFaceValue: \(die.dieFace!.faceValue), dieCount: \(die.dieFace!.countThisRoll)")
            count = die.dieFace!.countThisRoll
            //value = die.dieFace!.faceValue

            switch count {
            case 1:
                //print("single \(die.dieFace!.faceValue) found")
                if die.dieFace!.faceValue == 1 || die.dieFace!.faceValue == 5 {
                    currentPlayer.hasScoringDice = true
                    singles = true
                }
            case 2:
                //print("pair of \(die.dieFace!.faceValue)'s found")
                if die.dieFace!.faceValue == 1 || die.dieFace!.faceValue == 5 {
                    currentPlayer.hasScoringDice = true
                    singles = true
                }
                pairs += 1
            case 3:
                if pairs == 1 {
                    break
                }
                threeOAK = true
                threeOAKFaceValue = die.dieFace!.faceValue
                currentPlayer.hasScoringDice = true
                scoreDice(key: "ThreeOAK")
                die.dieFace!.countThisRoll = 0
            case 4:
                fourOAK = true
                threeOAKFaceValue = die.dieFace!.faceValue
                currentPlayer.hasScoringDice = true
                scoreDice(key: "ThreeOAK")
                die.dieFace!.countThisRoll = 0
            case 5:
                fiveOAK = true
                fiveOAKFaceValue = die.dieFace!.faceValue
                currentPlayer.hasScoringDice = true
                scoreDice(key: "ThreeOAK")
                die.dieFace!.countThisRoll = 0
            case 6:
                sixOAK = true
                sixOAKFaceValue = die.dieFace!.faceValue
                currentPlayer.hasScoringDice = true
                scoreDice(key: "ThreeOAK")
                die.dieFace!.countThisRoll = 0
            default:
                break
            }
            print("Die Value: \(die.dieFace!.faceValue), Die Count: \(die.dieFace!.countThisRoll)")
        }

        if pairs == 1 && threeOAK == true {
            fullHouse = true
            threeOAK = false
            pairs = 0
            currentPlayer.hasScoringDice = true
            scoreDice(key: "FullHouse")
        } else if pairs == 3 {
            threePair = true
            pairs = 0
            currentPlayer.hasScoringDice = true
            scoreDice(key: "ThreePair")
        }
        currentDieValuesArray.removeAll()

        for die in currentDiceArray {
            currentDieValuesArray.append(die.dieFace!.faceValue)
        }

        let sortedDieValues = currentDieValuesArray.sorted()
        if sortedDieValues == [1,2,3,4,5] || sortedDieValues == [2,3,4,5,6] || sortedDieValues == [1,2,3,4,5,6] {
            straight = true
            currentPlayer.hasScoringDice = true
            scoreDice(key: "Straight")
        }
        print("Scoring Keys: \(scoringCombosArray.keys)")
        print("Scoring Values: \(scoringCombosArray.values)")

        /*
        for (key, value) in scoringCombosArray {
            if value == true {
                scoreDice(key: key)
            }
        }
        */

        currentDiceArray.removeAll(where: { $0.selected })
        isComplete(true)
    }

    func scoreDice(key: String) {
        for (_, _) in scoringCombosArray {  //where key == combo {
            switch key {
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
                //print("Three pair found")
                currentScore = 500
                pairs = 0
                positionDice()
                startNewRoll()
            case "ThreeOAK":
                print("three of a kind")
                currentScore = calcScore(count: 3)
            case "FourOAK":
                //print("four of a kind")
                currentScore = calcScore(count: 4)
            case "FiveOAK":
                //print("five of a kind")
                currentScore = calcScore(count: 5)
            case "SixOAK":
                //print("six of a kind")
                currentScore = calcScore(count: 6)
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
    }

    func calcScore(count: Int) -> Int {
        print("Calculating Scoring Combo")
        var result = 0
        for die in currentDiceArray where die.dieFace?.countThisRoll == count {
            if die.dieFace!.faceValue == 1 {
                result = (1000 * (count - 2))
            } else {
                result = ((die.dieFace!.faceValue * 100) * (count - 2))
            }
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
        }
        return result
    }

    func resetDieCount() {
        for die in currentDiceArray {
            die.dieFace?.countThisRoll = 0
        }
        for die in selectedDieArray {
            die.dieFace?.countThisRoll = 0
        }
    }

    func resetScoringCombos() {
        for (key, _) in scoringCombosArray {
            scoringCombosArray[key] = false
        }
    }

    func resetCounters() {
        pairs = 0
        for die in currentDiceArray {
            die.selected = false
            die.counted = false
        }
    }

    func rollDiceAction() {
        for die in currentDiceArray {
            var rollAction: SKAction = SKAction()
            let Wait = SKAction.wait(forDuration: 0.15)

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
        switch die.dieFace?.faceValue {
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
        let moveDie1 = SKAction.move(to: die1PlaceHolder.position, duration: 0.25)
        let moveDie2 = SKAction.move(to: die2PlaceHolder.position, duration: 0.25)
        let moveDie3 = SKAction.move(to: die3PlaceHolder.position, duration: 0.25)
        let moveDie4 = SKAction.move(to: die4PlaceHolder.position, duration: 0.25)
        let moveDie5 = SKAction.move(to: die5PlaceHolder.position, duration: 0.25)
        let moveDie6 = SKAction.move(to: die6PlaceHolder.position, duration: 0.25)

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

        let seq1 = SKAction.sequence([moveDice1, resetDice])

        let seq2 = SKAction.sequence([moveDice2, resetDice])

        for die in currentDiceArray {
            if currentGame.numDice == 5 {
                die.run(seq1)
            } else {
                die.run(seq2)
            }
        }
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

    func resetDice() {
        currentDiceArray = diceArray
        selectedDieArray.removeAll()
        for die in currentDiceArray {
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

    func moveDiceCollection(count: Int){

        let moveDie1 = SKAction.move(to: die1PlaceHolder.position, duration: 0.25)
        let moveDie2 = SKAction.move(to: die2PlaceHolder.position, duration: 0.25)
        let moveDie3 = SKAction.move(to: die3PlaceHolder.position, duration: 0.25)
        let moveDie4 = SKAction.move(to: die4PlaceHolder.position, duration: 0.25)
        let moveDie5 = SKAction.move(to: die5PlaceHolder.position, duration: 0.25)
        let moveDie6 = SKAction.move(to: die6PlaceHolder.position, duration: 0.25)

        for die in currentDiceArray where die.dieFace!.countThisRoll == count {
            die.selected = true
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
    }

    func displayScore() {
        currentPlayer.currentRollScore += currentScore
        currentRollScoreLabel.text = String(currentPlayer.currentRollScore)
        currentScore = 0
    }
}
