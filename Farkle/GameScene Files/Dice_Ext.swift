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
        
        die1 = SKSpriteNode(texture: GameConstants.Textures.Die1)
        die1.name = "Die 1"
        die2 = SKSpriteNode(texture: GameConstants.Textures.Die2)
        die2.name = "Die 2"
        die3 = SKSpriteNode(texture: GameConstants.Textures.Die3)
        die3.name = "Die 3"
        die4 = SKSpriteNode(texture: GameConstants.Textures.Die4)
        die4.name = "Die 4"
        die5 = SKSpriteNode(texture: GameConstants.Textures.Die5)
        die5.name = "Die 5"
        die6 = SKSpriteNode(texture: GameConstants.Textures.Die6)
        die6.name = "Die 6"

        switch currentGame.numDice {
        case 5:
            diceArray = [die1, die2, die3, die4, die5]
        case 6:
            diceArray = [die1, die2, die3, die4, die5, die6]
        default:
            break
        }
    
        for dice in diceArray {
            dice.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Die1"), size: (CGSize(width: 32, height: 32)))
            dice.physicsBody?.affectedByGravity = false
            dice.physicsBody?.isDynamic = true
            dice.physicsBody?.allowsRotation = true
            dice.physicsBody?.categoryBitMask = 1
            dice.physicsBody?.contactTestBitMask = 1
            dice.physicsBody?.collisionBitMask = 1
            dice.physicsBody?.restitution = 0.5
            dice.physicsBody?.linearDamping = 4
            dice.physicsBody?.angularDamping = 5
        }
        positionDice()
    }
    
    func positionDice() {
        for dice in diceArray {
            dice.zRotation = 0
            dice.zPosition = GameConstants.ZPositions.Dice
            dice.size = CGSize(width: 32, height: 32)
            
            switch dice.name {
            case "Die 1":
                dice.position = CGPoint(x: -(gameTable.size.width / 7), y: gameTable.frame.minY + 100)
                die1.position = dice.position
            case "Die 2":
                dice.position = CGPoint(x: die1.position.x + dice.size.width, y: gameTable.frame.minY + 100)
                die2.position = dice.position
            case "Die 3":
                dice.position = CGPoint(x: die2.position.x + dice.size.width, y: gameTable.frame.minY + 100)
                die3.position = dice.position
            case "Die 4":
                dice.position = CGPoint(x: die3.position.x + dice.size.width, y: gameTable.frame.minY + 100)
                die4.position = dice.position
            case "Die 5":
                dice.position = CGPoint(x: die4.position.x + dice.size.width, y: gameTable.frame.minY + 100)
                die5.position = dice.position
            case "Die 6":
                dice.position = CGPoint(x: die5.position.x + dice.size.width, y: gameTable.frame.minY + 100)
                die6.position = dice.position
            default:
                break
            }
            gameTable.addChild(dice)
        }
    }
}

/*

    func rollDice() {
        if gameState == .InProgress{
            playerState = .Rolling
            
            if let RollAction = SKAction(named: "RollDice") {
                rollAction = RollAction
            }
            let finishRollAction = SKAction.run {
                self.setDieFace()
            }
            let seq = SKAction.sequence([rollAction, finishRollAction])
            
            let randomX = CGFloat(arc4random_uniform(5) + 5)
            let randomY = CGFloat(arc4random_uniform(2) + 3)
            
            for dieNode in dice {
                if dieNode.selected == true {
                    player.scoringDice.append(dieNode)
                } else {
                    dieNode.physicsBody?.applyImpulse(CGVector(dx: randomX, dy: randomY))
                    dieNode.physicsBody?.applyTorque(3)
                    dieNode.run(seq)
                }
            }
            player.Roll.diceRemaining -= player.scoringDice.count
        } else {
            gameState = .InProgress
        }
        if player.Roll.diceRemaining == 0 {
            setupNewRoll()
        }
            
    }
    
    func setupNewRoll() {
        
        
    }
    
    func wasDiceTouched() {
        for dieNode in dice {
            if dieNode.contains(gameTableTouchLocation) {
                if dieNode.selected == false {
                    switch dieNode.faceValue {
                    case 1:
                        dieNode.texture = SKTexture(imageNamed: "Selectable_Die1")
                    case 2:
                        dieNode.texture = SKTexture(imageNamed: "Selectable_Die2")
                    case 3:
                        dieNode.texture = SKTexture(imageNamed: "Selectable_Die3")
                    case 4:
                        dieNode.texture = SKTexture(imageNamed: "Selectable_Die4")
                    case 5:
                        dieNode.texture = SKTexture(imageNamed: "Selectable_Die5")
                    case 6:
                        dieNode.texture = SKTexture(imageNamed: "Selectable_Die6")
                    default:
                        break
                    }
                    dieNode.selected = true
                } else {
                    switch dieNode.faceValue {
                    case 1:
                        dieNode.texture = SKTexture(imageNamed: "Die1")
                    case 2:
                        dieNode.texture = SKTexture(imageNamed: "Die2")
                    case 3:
                        dieNode.texture = SKTexture(imageNamed: "Die3")
                    case 4:
                        dieNode.texture = SKTexture(imageNamed: "Die4")
                    case 5:
                        dieNode.texture = SKTexture(imageNamed: "Die5")
                    case 6:
                        dieNode.texture = SKTexture(imageNamed: "Die6")
                    default:
                        break
                    }
                    dieNode.selected = false
                }
            }
        }
    }

    
    func setDieFace() {
        for die in dice {
            if die.selected != true {
                die.faceValue = Int(arc4random_uniform(6)) + 1
                switch die.faceValue {
                case 1:
                    die.scoringDie = true
                    die.texture = GameConstants.StringConstants.die1Texture
                case 2:
                    die.texture = GameConstants.StringConstants.die2Texture
                case 3:
                    die.texture = GameConstants.StringConstants.die3Texture
                case 4:
                    die.texture = GameConstants.StringConstants.die4Texture
                case 5:
                    die.scoringDie = true
                    die.texture = GameConstants.StringConstants.die5Texture
                case 6:
                    die.texture = GameConstants.StringConstants.die6Texture
                default:
                    break
                }
                if die.scoringDie == false {
                    checkForScoringCombos()
                }
            }
            if playerState != .Farkle {
                if player.Roll.diceRemaining == 0 {
                    playerState = .Rolling
                }
            } else {
                gameState = .NewRound
            }
        }
    }
    
    func checkForScoringCombos() {
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
        
        for die in dice {
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
}

*/

