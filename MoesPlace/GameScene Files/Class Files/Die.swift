//
//  Die.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/22/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

class Die: SKSpriteNode {
    var selected: Bool = false
    var selectable: Bool = true
    var counted: Bool = false
    var dieSide: DieSide?
}
