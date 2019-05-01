//
//  DieFace.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

class DieFace
{
    let faceValue : Int
    var countThisRoll : Int = 0

    init(faceValue: Int)
    {
        self.faceValue = faceValue
    }
}

/*
struct DieSide {
    
    var name: String
    var dieValue: [String:Int]
    var points: Int

    init(name: String, dieValue: [String:Int], points: Int) {
        self.name = name
        self.dieValue = dieValue
        //self.value = value
        //self.count = count
        self.points = points
    }
}
*/

