//
//  DieFaceDef.swift
//  Farkle
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

class dieFaceDef {
    
    let name: String
    var faceValue: Int
    let points: Int
    var scoring: Bool
    
    var countThisRoll: Int = Int(0)
    
    init(name: String, faceValue: Int, points: Int, scoring: Bool)
    {
        self.name = name
        self.faceValue = faceValue
        self.points = points
        self.scoring = scoring
    }
}
