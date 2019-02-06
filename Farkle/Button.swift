//
//  Button.swift
//  Farkle
//
//  Created by Mark Davis on 2/5/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit
import UIKit

class Button: SKSpriteNode {
    
    var Name: String = String()
    var ImageName: String = String()
    let Texture: SKTexture = SKTexture(imageNamed: "Button")
    let Size =  CGSize(width: 128, height: 48)
    var Position: CGPoint = CGPoint()
    let ZPosition = 2
}
