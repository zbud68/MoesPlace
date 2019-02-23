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
        
        die1.texture = GameConstants.Textures.Die1
        die1.name = "Die 1"
        die1.face = 1
        die2.texture = GameConstants.Textures.Die2
        die2.name = "Die 2"
        die2.face = 2
        die3.texture = GameConstants.Textures.Die3
        die3.name = "Die 3"
        die3.face = 3
        die4.texture = GameConstants.Textures.Die4
        die4.name = "Die 4"
        die4.face = 4
        die5.texture = GameConstants.Textures.Die5
        die5.name = "Die 5"
        die5.face = 5
        die6.texture = GameConstants.Textures.Die6
        die6.name = "Die 6"
        die6.face = 6

        switch currentGame.numDice {
        case 5:
            diceArray = [die1, die2, die3, die4, die5]
        case 6:
            diceArray = [die1, die2, die3, die4, die5, die6]
        default:
            break
        }
        
        currentDice = diceArray
    
        for die in currentDice {
            die.isSelected = false
            die.physicsBody = SKPhysicsBody(rectangleOf: GameConstants.Sizes.Dice)
            //(texture: GameConstants.Textures.Die1, size: GameConstants.Sizes.Dice)
            die.physicsBody?.affectedByGravity = false
            die.physicsBody?.isDynamic = true
            die.physicsBody?.allowsRotation = true
            die.physicsBody?.categoryBitMask = 1
            die.physicsBody?.contactTestBitMask = 1
            die.physicsBody?.collisionBitMask = 1
            die.physicsBody?.restitution = 0.5
            die.physicsBody?.linearDamping = 4
            die.physicsBody?.angularDamping = 5
        }
        positionDice()
    }
    
    func positionDice() {
        for die in currentDice {
            die.zRotation = 0
            die.zPosition = GameConstants.ZPositions.Dice
            die.size = GameConstants.Sizes.Dice
            
            switch die.name {
            case "Die 1":
                die1.position = CGPoint(x: -(gameTable.size.width / 7), y: gameTable.frame.minY + 100)
            case "Die 2":
                die2.position = CGPoint(x: die1.position.x + die2.size.width, y: gameTable.frame.minY + 100)
            case "Die 3":
                die3.position = CGPoint(x: die2.position.x + die3.size.width, y: gameTable.frame.minY + 100)
            case "Die 4":
                die4.position = CGPoint(x: die3.position.x + die4.size.width, y: gameTable.frame.minY + 100)
            case "Die 5":
                die5.position = CGPoint(x: die4.position.x + die5.size.width, y: gameTable.frame.minY + 100)
            case "Die 6":
                die6.position = CGPoint(x: die5.position.x + die6.size.width, y: gameTable.frame.minY + 100)
            default:
                break
            }
            gameTable.addChild(die)
        }
    }
    
    func resetDice() {
        currentDice.removeAll()
        currentScore = 0
        currentPlayer.currentRollScore = 0
        for dieFace in dieFaceArray {
            dieFace.countThisRoll = 0
        }
    
        for die in diceArray {
            die.face = 0
            die.isSelected = false
            die.physicsBody?.pinned = false
            
            die.zRotation = 0
            die.zPosition = GameConstants.ZPositions.Dice
            die.size = GameConstants.Sizes.Dice
            
            switch die.name {
            case "Die 1":
                die1.position = CGPoint(x: -(gameTable.size.width / 7), y: gameTable.frame.minY + 100)
                die1.texture = GameConstants.Textures.Die1
                
            case "Die 2":
                die2.position = CGPoint(x: die1.position.x + die2.size.width, y: gameTable.frame.minY + 100)
                die2.texture = GameConstants.Textures.Die2
            case "Die 3":
                die3.position = CGPoint(x: die2.position.x + die3.size.width, y: gameTable.frame.minY + 100)
                die3.texture = GameConstants.Textures.Die3
            case "Die 4":
                die4.position = CGPoint(x: die3.position.x + die4.size.width, y: gameTable.frame.minY + 100)
                die4.texture = GameConstants.Textures.Die4
            case "Die 5":
                die5.position = CGPoint(x: die4.position.x + die5.size.width, y: gameTable.frame.minY + 100)
                die5.texture = GameConstants.Textures.Die5
            case "Die 6":
                die6.position = CGPoint(x: die5.position.x + die6.size.width, y: gameTable.frame.minY + 100)
                die6.texture = GameConstants.Textures.Die6
            default:
                break
            }
        }
        currentDice = diceArray
 }

    //MARK: ********** Roll Dice **********
    
    func rollDiceAction() {
        for die in currentDice {
            rollDice(die: die)
            if currentPlayer.firstRoll != true {
                checkForFarkle()
            }
            currentPlayer.currentRollScore += currentScore
            currentScore = 0
            for dieFace in dieFaceArray {
                dieFace.countThisRoll = 0
            }
        }
        currentPlayer.firstRoll = false
        currentPlayer.score += currentPlayer.currentRollScore
        currentPlayer.currentRollScore = 0
        currentPlayer.scoreLabel.text = String(currentPlayer.score)
    }

    func rollDice(die: Die) {
        
        let Wait = SKAction.wait(forDuration: 0.75)

        if let RollAction = SKAction(named: "RollDice") {
            rollAction = RollAction
        }
        
        let MoveAction = SKAction.run {
            let randomX = CGFloat(arc4random_uniform(5) + 5)
            let randomY = CGFloat(arc4random_uniform(2) + 3)
            
            if die.isSelected != true {
                die.physicsBody?.applyImpulse(CGVector(dx: randomX, dy: randomY))
                die.physicsBody?.applyTorque(3)
            }
        }

        let setFace = SKAction.run {
            self.setDieFace(die: die)
        }
    
        let FadeOut = SKAction.fadeAlpha(to: 0, duration: 0.75)
        let FadeIn = SKAction.fadeAlpha(to: 1, duration: 0.75)
        
        let RepositionDice = SKAction.run {
            self.repositionDice(die: die)
        }
        
        let Group = SKAction.group([rollAction, MoveAction])
        
        let Seq = SKAction.sequence([Group, setFace, Wait, FadeOut, RepositionDice, FadeIn])
        
        for die in currentDice {
                die.position = CGPoint(x: 0, y: 0)
            }
        
        die.run(Seq)
        playerState = .Idle
    }
    
    func setDieFace(die: Die) {

        let currentDie = Int(arc4random_uniform(6) + 1)
        
        currentRoll.append(currentDie)
        
        switch currentDie {
        case 1:
            die.texture = GameConstants.Textures.Die1
            die.face = 1
            dieFace1.countThisRoll += 1
        case 2:
            die.texture = GameConstants.Textures.Die2
            die.face = 2
            dieFace2.countThisRoll += 1
        case 3:
            die.texture = GameConstants.Textures.Die3
            die.face = 3
            dieFace3.countThisRoll += 1
        case 4:
            die.texture = GameConstants.Textures.Die4
            die.face = 4
            dieFace4.countThisRoll += 1
        case 5:
            die.texture = GameConstants.Textures.Die5
            die.face = 5
            dieFace5.countThisRoll += 1
        case 6:
            die.texture = GameConstants.Textures.Die6
            die.face = 6
            dieFace6.countThisRoll += 1
        default:
            break
        }
        getScore()
    }
    
    func repositionDice(die: SKSpriteNode) {
        die.zRotation = 0
        die.zPosition = GameConstants.ZPositions.Dice
        die.size = GameConstants.Sizes.Dice
        
        switch die.name {
        case "Die 1":
            die1.position = CGPoint(x: -(gameTable.size.width / 7), y: gameTable.frame.minY + 100)
        case "Die 2":
            die2.position = CGPoint(x: die1.position.x + die2.size.width, y: gameTable.frame.minY + 100)
        case "Die 3":
            die3.position = CGPoint(x: die2.position.x + die3.size.width, y: gameTable.frame.minY + 100)
        case "Die 4":
            die4.position = CGPoint(x: die3.position.x + die4.size.width, y: gameTable.frame.minY + 100)
        case "Die 5":
            die5.position = CGPoint(x: die4.position.x + die5.size.width, y: gameTable.frame.minY + 100)
        case "Die 6":
            die6.position = CGPoint(x: die5.position.x + die6.size.width, y: gameTable.frame.minY + 100)
        default:
            break
        }
    }
    
    func checkForFarkle() {
        for dieFace in dieFaceArray {
            if dieFace.scoring == true {
                if dieFace.countThisRoll > 0 {
                    currentPlayer.hasScoringDice = true
                    if currentDice.count >= 1 {
                        currentDice.removeLast()
                    } else {
                        gameState = .NewRoll
                    }
                }
            }
        }
        
        if playerState == .Rolling {
            if currentPlayer.hasScoringDice != true {
                print("FARKLE")
                playerState = .Farkle
            }
        }
    }
    
    func getScore() {

        let stop = checkForCombo()
        
        if stop == false {
            for dieFace in dieFaceArray {
                let value = dieFace.faceValue
                let points = dieFace.points
                let count = dieFace.countThisRoll
                
                switch count {
                case 1:
                    currentScore += (count * points)
                case 2:
                    currentScore += (count * points)
                case 3:
                    if dieFace.faceValue == 1 || dieFace.faceValue == 5 {
                        currentScore += (points * 10)
                    } else {
                        currentScore += (value * 100)
                    }
                case 4:
                    if dieFace.faceValue == 1 || dieFace.faceValue == 5 {
                        currentScore += (points * 10) * 2
                    } else {
                        currentScore += (value * 100) * 2
                    }
                case 5:
                    if dieFace.faceValue == 1 || dieFace.faceValue == 5 {
                        currentScore += (points * 10) * 3
                    } else {
                        currentScore += (value * 100) * 3
                    }
                case 6:
                    if dieFace.faceValue == 1 || dieFace.faceValue == 5 {
                        currentScore += (points * 10) * 4
                    } else {
                        currentScore += (value * 100) * 4
                    }
                default:
                    break
                }
                print("currentScore: \(currentScore)")
            }
        }
    }
    
    func checkForCombo() -> Bool {
        var stop = false
        var pair = false
        var pairCount = 0
        var threeOfAKind = false
        var threePair = false
        var threeOfAKindCount = 0
        
        var values: [Int] = []
        
        for dieFace in dieFaceArray {
            values.append(dieFace.faceValue)
            print("\(dieFace.name) count: \(dieFace.countThisRoll)")
        }
        
        currentScore = 0
        
        for dieFace in dieFaceArray {
            if dieFace.countThisRoll == 2 {
                pair = true
                pairCount += 1
            }
            if dieFace.countThisRoll == 3 {
                threeOfAKind = true
                threeOfAKindCount += 1
            }
        }
        
        if currentGame.numDice == 6 {
            if pairCount == 3 {
                print("three pair")
                threePair = true
            }
        }
        
        if pair == true && threeOfAKind == true {
            print("full House")
            currentScore = 750
            stop = true
        }
        
        values = values.sorted()
        
        if currentGame.numDice == 6 {
            if values == sixDieStraight {
                print("straight")
                currentScore = 1500
                stop = true
            }
            if threePair == true {
                print("three Pair")
                currentScore = 500
                stop = true
            }
        } else {
            if values == lowStraight || values == highStraight {
                print("straight")
                currentScore = 1500
                stop = true
            }
        }
        return stop
    }
}
