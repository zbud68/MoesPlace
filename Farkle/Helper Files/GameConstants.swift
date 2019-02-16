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
        static let players = 4
        static let dice = 6
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

    struct StringConstants {
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

        static let IconWindowImageName = "WindowPopup1"
        static let ScoresWindowImageName = "WindowPopup2"
        static let GameTableImageName = "WindowPopup"
        static let MainMenuImageName = "MainMenu"
        static let SettingsMenuImageName = "SettingsMenu"
        static let HelpMenuImageName = "HelpMenu"
        static let BackGroundImageName = "Felt_Green"
    }

    struct ZPositions {
        static let BackGround: CGFloat = 0
        static let GameTable: CGFloat = 1
        static let Window: CGFloat = 2
        static let Logo: CGFloat = 3
        static let Icon: CGFloat = 3
        static let IconLabel: CGFloat = 4
        static let NameLabel: CGFloat = 4
        static let Dice: CGFloat = 5
        static let Message: CGFloat = 6
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
        static let Winner = "has won the game."
        static let GameOver = "Has finished the game.\n Remaining players have 1 final roll."
        static let Busted = "You must match the target score exactly to win"
        static let Farkle = "No scoring dice"
    }

    struct MainMenu {
        static let FontName = GameConstants.Logo.FontName
        static let FontColor = GameConstants.Logo.FontColor
        static let FontSize = GameConstants.Logo.FontSize2
    }

    struct ScoresMenu {
        static let FontName = GameConstants.Logo.FontName
        static let FontColor = GameConstants.Logo.FontColor
        static let FontSize = GameConstants.Logo.FontSize2
        static let ImageName = "WindowPop2"
        static let Size = CGSize(width: 150, height: 330)
    }

    struct Icon {
        static let FontName = "Marker Felt Wide"
        static let FontColor = UIColor.black
        static let FontSize: CGFloat = 24
        static let Size = CGSize(width: 35, height: 35)
    }

    /*
    struct Dice {
        static let PhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
        static let Size = CGSize(width: 64, height: 64)
        static let PhysicsCategoryMask: UInt32 = GameConstants.PhysicsCategory.Dice
        static let PhysicsContactMask: UInt32 = GameConstants.PhysicsCategory.Frame
        static let PhysicsCollisionMask: UInt32 = GameConstants.PhysicsCategory.Frame

        static let Gravity = false
        static let AllowsRotation = true
        static let Dynamic = true
    }
    */

    /*
    struct GameTable {
        static let physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 75, y: 0, width: 750, height: 440))
        static let ImageName = "WindowPopup"

        static let PhysicsCategoryMask: UInt32 = GameConstants.PhysicsCategory.Frame
        static let PhysicsContacMask: UInt32 = GameConstants.PhysicsCategory.Dice
        static let PhysicsCollisionMask: UInt32 = GameConstants.PhysicsCategory.Dice

        static let Gravity = false
        static let AllowsRotation = true
        static let Dynamic = true
    }
    */

    struct BackGround {
        static let Name = "BackGround"
        static let ImageName = "Felt_Green"
        static let Position = CGPoint(x: 0, y: 0)
    }

    struct Logo {
        static let FontName = "Marker Felt Wide"
        static let FontColor = UIColor.brown
        static let FontSize1: CGFloat = 144
        static let FontSize2: CGFloat = 34
    }
    
    struct PlayerNameLabel {
        static let FontName = "Marker Felt Wide"
        static let FontColor = UIColor.brown
        static let FontSize: CGFloat = 25
    }
    
    struct PlayerScoreLabel {
        static let FontName = "Marker Felt Wide"
        static let FontColor = UIColor.black
        static let FontSize: CGFloat = 25
    }

}
