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
        die2.texture = GameConstants.Textures.Die2
        die2.name = "Die 2"
        die3.texture = GameConstants.Textures.Die3
        die3.name = "Die 3"
        die4.texture = GameConstants.Textures.Die4
        die4.name = "Die 4"
        die5.texture = GameConstants.Textures.Die5
        die5.name = "Die 5"
        die6.texture = GameConstants.Textures.Die6
        die6.name = "Die 6"

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
            die.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Die1"), size: (CGSize(width: 32, height: 32)))
            die.physicsBody?.affectedByGravity = false
            die.physicsBody?.isDynamic = true
            die.physicsBody?.allowsRotation = true
            die.physicsBody?.categoryBitMask = 1
            die.physicsBody?.contactTestBitMask = 1
            die.physicsBody?.collisionBitMask = 1
            die.physicsBody?.restitution = 0.5
            die.physicsBody?.linearDamping = 4
            die.physicsBody?.angularDamping = 5
            positionDice(die: die)
        }
    }
    
    func positionDice(die: SKSpriteNode) {
            die.zRotation = 0
            die.zPosition = GameConstants.ZPositions.Dice
            die.size = CGSize(width: 32, height: 32)
            
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
    
    func resetDice() {
        currentDice.removeAll()
        currentScore = 0
        currentPlayer.currentRollScore = 0
        for dieFace in dieFaceArray {
            dieFace.countThisRoll = 0
        }
    
        for die in diceArray {
            die.zRotation = 0
            die.zPosition = GameConstants.ZPositions.Dice
            die.size = CGSize(width: 32, height: 32)
            
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
            currentPlayer.currentRollScore += currentScore
            currentScore = 0
            for dieFace in dieFaceArray {
                dieFace.countThisRoll = 0
            }
        }
        currentPlayer.score += currentPlayer.currentRollScore
        currentPlayer.currentRollScore = 0
        currentPlayer.scoreLabel.text = String(currentPlayer.score)


        
        /*
        for die in currentDice {
                for die in currentDice {
                    die.position = CGPoint(x: 0, y: 0)
                }
                
                let randomX = CGFloat(arc4random_uniform(5) + 5)
                let randomY = CGFloat(arc4random_uniform(2) + 3)
                
                die.physicsBody?.applyImpulse(CGVector(dx: randomX, dy: randomY))
                die.physicsBody?.applyTorque(3)
                
                rollDice(die: die)
        }
        */
    }
    
    func rollDice(die: SKSpriteNode) {
        
        let Wait = SKAction.wait(forDuration: 0.75)

        if let RollAction = SKAction(named: "RollDice") {
            rollAction = RollAction
        }
        
        let MoveAction = SKAction.run {
            let randomX = CGFloat(arc4random_uniform(5) + 5)
            let randomY = CGFloat(arc4random_uniform(2) + 3)
            
            die.physicsBody?.applyImpulse(CGVector(dx: randomX, dy: randomY))
            die.physicsBody?.applyTorque(3)
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
    }
    
    func setDieFace(die: SKSpriteNode) {

        let currentDie = Int(arc4random_uniform(6) + 1)
        
        switch currentDie {
        case 1:
            die.texture = GameConstants.Textures.Die1
            dieFace1.countThisRoll += 1
        case 2:
            die.texture = GameConstants.Textures.Die2
            dieFace2.countThisRoll += 1
        case 3:
            die.texture = GameConstants.Textures.Die3
            dieFace3.countThisRoll += 1
        case 4:
            die.texture = GameConstants.Textures.Die4
            dieFace4.countThisRoll += 1
        case 5:
            die.texture = GameConstants.Textures.Die5
            dieFace5.countThisRoll += 1
        case 6:
            die.texture = GameConstants.Textures.Die6
            dieFace6.countThisRoll += 1
        default:
            break
        }
        getScore()

        //checkForFarkle()
    }
    
    func repositionDice(die: SKSpriteNode) {
        die.zRotation = 0
        die.zPosition = GameConstants.ZPositions.Dice
        die.size = CGSize(width: 32, height: 32)
        
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
        
        if currentPlayer.hasScoringDice != true {
            print("FARKLE")
            playerState = .Farkle
        }
    }
    
    func getScore() {
        for dieFace in dieFaceArray {
            print("\(dieFace.name) count: \(dieFace.countThisRoll)")
        }
        currentScore = 0

        for dieFace in dieFaceArray {
            let value = dieFace.faceValue
            let points = dieFace.points
            let count = dieFace.countThisRoll
            
            switch count {
            case 1:
                currentScore += count * points
            case 2:
                currentScore += count * points
            case 3:
                currentScore += value * 100
            case 4:
                currentScore += (value * 100) * 2
            case 5:
                currentScore += (value * 100) * 3
            case 6:
                currentScore += (value * 100) * 4
            default:
                break
            }
            print("currentScore: \(currentScore)")
        }
    }
    
    func setupNewRoll() {
        
        
    }

/*    func checkForScoringCombos() {
        var ones = 0
        var twos = 0
        var threes = 0
        var fours = 0
        var fives = 0
        var sixes = 0
        var pairs = 0
        
        let lowStraight = [1,2,3,4,5]
        let highStraight = [2,3,4,5,6]
        let sixDieStraight = [1,2,3,4,5,6]
        
        let threeOfAKind = false
        var fourOfAKind = false
        var fiveOfAKind = false
        var sixOfAKind = false
        
        var straight = false
        var fullHouse = false
        var threePair = false
        
        var scoringDieFaceValue = 0
        
        var currentRoll = [ones, twos, threes, fours, fives, sixes]
        //var currentRoundScores: [Int] = []
        
        for die in diceArray {
            switch die.faceValue {
            case 1:
                ones += 1
                die.scoringDie = true
            case 2:
                twos += 1
            case 3:
                threes += 1
            case 4:
                fours += 1
            case 5:
                fives += 1
                die.scoringDie = true
            case 6:
                sixes += 1
            default:
                break
            }
        }
        currentRoll = currentRoll.sorted()

        
        if game.numDice == 5 {
            if currentRoll == lowStraight || currentRoll == highStraight {
                straight = true
            }
        } else {
            if currentRoll == sixDieStraight {
                straight = true
            }
        }
        if straight == true {
            playerState = .Scored
        }
        
        id = 0
        for die in currentRoll {
            switch currentRoll[id] {
            case ones:
                if ones > 0 {
                    //getPoints(dieFace: 1, numRolled: ones)
                    playerState = .Scored
                }
            case twos:
                if twos > 2 {
                    //getPoints(dieFace: 2, numRolled: twos)
                    playerState = .Scored
                }
            case threes:
                if threes > 2 {
                    //getPoints(dieFace: 3, numRolled: threes)
                    playerState = .Scored
                }
            case fours:
                if fours > 2 {
                    //getPoints(dieFace: 4, numRolled: fours)
                    playerState = .Scored
                }
            case fives:
                if fives > 0 {
                    //getPoints(dieFace: 5, numRolled: fives)
                    playerState = .Scored
                }
            case sixes:
                if sixes > 0 {
                    //getPoints(dieFace: 6, numRolled: sixes)
                    playerState = .Scored
                }
            default:
                break
            }
            id += 1
            if die == 2 {
                pairs += 1
            }
        }
        if pairs == 3 {
            //threePair = true
            playerState = .Scored
        }
        if threeOfAKind == true && pairs > 0 {
            //fullHouse = true
        }
    }
    
    func getPoints(dieFace: Int, numRolled: Int) {
        
        var pointsScored = 0
        
        var faceValue = dieFace
        
        if dieFace == 1 {
            faceValue = 10
        }
        switch numRolled {
        case 3:
            pointsScored = faceValue * 100
        case 4:
            pointsScored = (faceValue * 100) * 2
        case 5:
            pointsScored = (faceValue * 100) * 3
        case 6:
            pointsScored = (faceValue * 100) * 4
        default:
            break
        }
        player.Roll.score += pointsScored
    }
    
    func getPlayerSelectedDice() {
        id = 0
        for die in dice {
            if die.selected == true {
                dice.remove(at: id)
                player.scoringDice.append(die)
            }
            id += 1
        }
        player.Roll.diceRemaining -= player.scoringDice.count
        print("dice remaining: \(player.Roll.diceRemaining)")
        if player.Roll.diceRemaining == 0 {
            print("reset Dice")
        checkForScoringCombos()
        }
    }
 */
}
