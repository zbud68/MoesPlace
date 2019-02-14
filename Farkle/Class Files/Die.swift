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
    }
}
