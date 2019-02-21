//
//  DieFaceDef.swift
//  Farkle
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

class dieFaceDef {
    let faceValue: Int
    let scoring: Bool
    
    var countThisRoll: Int = Int(0)
    
    init(faceValue: Int, scoring: Bool)
    {
        self.faceValue = faceValue
        self.scoring = scoring
    }
}
