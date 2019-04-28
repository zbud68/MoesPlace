//
//  Icon_Ext.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    func setupButtonWindowButtons() {

        if let PauseButton = buttonWindow.childNode(withName: "PauseButton") as? SKSpriteNode {
            pauseButton = PauseButton
            //pauseButton.isPaused = true

        } else {
            print("pause button not found")
        }

        if let RollDiceButton = buttonWindow.childNode(withName: "RollButton") as? SKSpriteNode {
            rollDiceButton = RollDiceButton
            //rollDiceButton.isPaused = true
        } else {
            print("roll dice button not found")
        }

        if let KeepScoreButton = buttonWindow.childNode(withName: "KeepButton") as? SKSpriteNode {
            keepScoreButton = KeepScoreButton
            //keepScoreButton.isPaused = true
       } else {
            print("keep button not found")
        }

        
        /*
        pauseIcon.texture = SKTexture(imageNamed: "GreenPause")
        pauseIcon.name = "Pause"
        pauseIcon.size = CGSize(width: 32, height: 32)
        pauseIcon.zPosition = GameConstants.ZPositions.Icon
        
        pauseIcon.position = CGPoint(x: (pauseIcon.size.width / 2) - (iconWindow.size.width / 3) + 3, y: iconWindow.size.height / 3 - pauseIcon.size.height)
        
        rollDiceIcon.texture = SKTexture(imageNamed: "IconRed")
        rollDiceIcon.position = CGPoint(x: pauseIcon.position.x + 60, y: iconWindow.size.height / 5 - rollDiceIcon.size.height)
        rollDiceIcon.name = "RollDice"
        rollDiceIcon.size = CGSize(width: 60, height: 40)
        rollDiceIcon.zPosition = GameConstants.ZPositions.Dice
        
        keepScoreIcon.texture = SKTexture(imageNamed: "IconGreen")
        keepScoreIcon.position = CGPoint(x: rollDiceIcon.position.x, y: rollDiceIcon.position.y - 40)
        keepScoreIcon.name = "KeepScore"
        keepScoreIcon.size = CGSize(width: 60, height: 40)
        keepScoreIcon.zPosition = GameConstants.ZPositions.Dice
        */

        setupButtonWindowButtonsArray()
    }

    func setupMainMenuButtonsArray() {
        mainMenuButtonsArray = [newGameButton, resumeGameButton, settingsButton, exitButton, infoButton]
    }
    
    func setupSettingsMenuButtonsArray() {
        settingsMenuButtonsArray = [soundButton, backButton]
    }
    
    func setupButtonWindowButtonsArray() {        
        buttonWindowButtonsArray = [pauseButton, rollDiceButton, keepScoreButton]
    }
    
    func addIconWindowIcons() {
        //buttonWindow.addChild(pauseButton)
        //buttonWindow.addChild(rollDiceButton)
        //buttonWindow.addChild(keepScoreButton)
    }
}
