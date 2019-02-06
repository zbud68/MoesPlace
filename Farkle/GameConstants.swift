//
//  GameConstants.swift
//  Farkle
//
//  Created by Mark Davis on 2/5/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit
import UIKit

struct GameConstants {
    
    struct GameDefaults {
        static let targetScore = 10000
        static let players = 1
        static let dice = 5
        static let matchTarget = true
        static let playerScore = 0
        static let round = 1
    }
    
    struct ScoringComboValues {
        static let ones = 100
        static let fives = 50
        static let multiplier_3456_OfAKind = 100
        static let straight = 1500
        static let fullHouse = 750
        static let threePair = 750
    }
    
    struct StingConstants {
        static let player1Name = "Player 1"
        static let player2Name = "Player 2"
        static let player3Name = "Player 3"
        static let player4Name = "Player 4"
        
        static let die1ImageName = "Die1"
        static let die2ImageName = "Die2"
        static let die3ImageName = "Die3"
        static let die4ImageName = "Die4"
        static let die5ImageName = "Die5"
        static let die6ImageName = "Die6"
        
        static let die1Texture = SKTexture(imageNamed: "Die1")
        static let die2Texture = SKTexture(imageNamed: "Die2")
        static let die3Texture = SKTexture(imageNamed: "Die3")
        static let die4Texture = SKTexture(imageNamed: "Die4")
        static let die5Texture = SKTexture(imageNamed: "Die5")
        static let die6Texture = SKTexture(imageNamed: "Die6")
        
        static let die1Name = "Die1"
        static let die2Name = "Die2"
        static let die3Name = "Die3"
        static let die4Name = "Die4"
        static let die5Name = "Die5"
        static let die6Name = "Die6"
    }

    struct Menu {
        static let fontName = "Marker Felt Wide"
        static let fontColor = UIColor.black
        static let fontSize: CGFloat = 34
        static let ZPos: CGFloat = 2
        static let ImageName = "Casual Game GUI_Window - Wide"
        static let Texture = SKTexture(imageNamed: "Casual Game GUI_Window - Wide")
        //static let Size =  CGSize(width: (gameScene.size.width) + 100, height: (gameScene.size.height) + 50)
        //static let Position = CGPoint(x: (gameScene.position.x), y: (gameScene.position.y))
        static let ZPosition = 1

    }
    
    struct Button {
        static let fontName = "Marker Felt Wide"
        static let fontColor = UIColor.black
        static let fontSize: CGFloat = 24
        static let ZPos: CGFloat = 2
        static let Texture = SKTexture(imageNamed: "PlayButton")
        static let Size =  CGSize(width: 128, height: 48)
    }
    
    struct Dice {
        static let PhysicBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
        static let Size = CGSize(width: 64, height: 64)
        static let ZPosition = CGFloat(10)
        static let PhysicsCategoryMask: UInt32 = 1
        static let PhysicsContactMask: UInt32 = 1
        static let PhysicsCollisionMask: UInt32 = 1
        static let Gravity = false
        static let AllowsRotation = true
        static let Dynamic = true
    }
    
    struct PhysicsCategory {
        static let Dice = UInt32(1)
        static let Frame = UInt32(2)
        static let World = UInt32(4)
        static let Other = UInt32(8)
    }
    
    struct Messages {
        static let GameInProgress = "There is currently a game in progress. Press 'Continue' to abandon game in progress and return to main menu, or 'Cancel' and press 'Resume Game' from main menu to contiue the game in progress"
        static let NoGameInProgress = "There is no game in progress, select 'Play' from the main menu to start a new game"
        static let Winner = "has won the game." //((VC2.CurrentPlayerNameLabel.text)!)
        static let GameOver = "Has finished the game.\n Remaining players have 1 final roll." //\((VC2.CurrentPlayerNameLabel.text)!)
        static let Busted = "You must match the target score exactly to win"
        static let Farkle = "No scoring dice"
    }
    
    struct GameTable {
        static let Name = "Game Table"
        static let ImageName = "Felt_Green"
        static let Texture = SKTexture(imageNamed: "Felt_Green1")
        //static let Size = gameScene.size
        static let Position = CGPoint(x: 0, y: 0)
    }

    struct ZPositions {
        static let GameTable = 0
        static let Menu = 1
        static let Button = 2
        static let ButtonLabel = 3
        static let Dice = 4
        static let Message = 5
    }
}
