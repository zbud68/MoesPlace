//
//  Die.swift
//  Farkle
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

class Die: SKSpriteNode {
    var faceValue: Int = Int()
    var rollResults: [Int] = []
    var selected: Bool = false

    func setDieFace() {
        //rollResults.removeAll()
        /*
        for _ in 0 ... 5 {
            let dieValue = Int(arc4random_uniform(6)) + 1
            rollResults.append(dieValue)
        }
        */
        
        for die in dice {
            die.faceValue = Int(arc4random_uniform(6)) + 1
            switch die.faceValue {
            case 1:
                die.texture = GameConstants.StringConstants.die1Texture
            case 2:
                die.texture = GameConstants.StringConstants.die2Texture
            case 3:
                die.texture = GameConstants.StringConstants.die3Texture
            case 4:
                die.texture = GameConstants.StringConstants.die4Texture
            case 5:
                die.texture = GameConstants.StringConstants.die5Texture
            case 6:
                die.texture = GameConstants.StringConstants.die6Texture
            default:
                break
            }
        }

        /*
        for roll in rollResults {
            print("Roll: \(roll)")
            switch roll {
                case 1:
                    // die1Frame.position = Dice[id].position
                    dice[id].texture = SKTexture(imageNamed: "Die1")
                    dice[id].faceValue = 1
                    print(rollResults[id])
                case 2:
                    // die2Frame.position = Dice[id].position
                    dice[id].texture = SKTexture(imageNamed: "Die2")
                    dice[id].faceValue = 2
                    print(rollResults[id])
                case 3:
                    // die3Frame.position = Dice[id].position
                    dice[id].texture = SKTexture(imageNamed: "Die3")
                    dice[id].faceValue = 3
                    print(rollResults[id])
                case 4:
                    // die4Frame.position = Dice[id].position
                    dice[id].texture = SKTexture(imageNamed: "Die4")
                    dice[id].faceValue = 4
                    print(rollResults[id])
                case 5:
                    // die5Frame.position = Dice[id].position
                    dice[id].texture = SKTexture(imageNamed: "Die5")
                    dice[id].faceValue = 5
                    print(rollResults[id])
                case 6:
                    // die6Frame.position = Dice[id].position
                    dice[id].texture = SKTexture(imageNamed: "Die6")
                    dice[id].faceValue = 6
                    print(rollResults[id])
                default:
                    break
            }
        }
        */
    }
}
