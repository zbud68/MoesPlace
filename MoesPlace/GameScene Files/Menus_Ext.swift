//
//  Menus_Ext.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/20/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    func setupMainMenu() {
        if let MainMenu = gameTable.childNode(withName: "MainMenu") as? SKSpriteNode {
            mainMenu = MainMenu
        } else {
            print("main menu not found")
        }
        mainMenu.position = CGPoint(x: 0, y: 0)
        mainMenu.alpha = 1

        /*
         mainMenu.texture = GameConstants.Textures.MainMenu
         mainMenu.name = "MainMenu"
         mainMenu.position = CGPoint(x: 0, y: 0)
         mainMenu.size = CGSize(width: frame.size.width / 2, height: frame.size.height / 1.5)
         mainMenu.zPosition = GameConstants.ZPositions.Menu
         */
    }

    func setupSettingsMenu() {
        if let SettingsMenu = gameTable.childNode(withName: "SettingsMenu") as? SKSpriteNode {
            settingsMenu = SettingsMenu
        } else {
            print("settings menu not found")
        }
        //settingsMenu.isPaused = true
        settingsMenu.position = CGPoint(x: 500, y: 0)
        //settingsMenu.position = CGPoint(x: 10000, y: 10000)

        /*
         settingsMenu.texture = GameConstants.Textures.SettingsMenu
         settingsMenu.name = "SettingsMenu"
         settingsMenu.position = CGPoint(x: 0, y: 0)
         settingsMenu.size = CGSize(width: frame.size.width / 2, height: frame.size.height / 1.5)
         settingsMenu.zPosition = GameConstants.ZPositions.Menu
         */
        setupSettingsMenuButtons()
    }

    func setupHelpMenu() {
        if let HelpMenu = gameTable.childNode(withName: "HelpMenu") as? SKSpriteNode {
            helpMenu = HelpMenu
        } else {
            print("help menu not found")
        }
        //helpMenu.isPaused = true
        helpMenu.position = CGPoint(x: 500, y: -150)
        //helpMenu.position = CGPoint(x: 10000, y: 10000)

    }
    
    func setupMainMenuButtons() {
        if let NewGameButton = mainMenu.childNode(withName: "NewGameButton") as? SKSpriteNode {
            newGameButton = NewGameButton
        } else {
            print("new game button not found")
        }

        /*
        newGameIcon.texture = SKTexture(imageNamed: "GreenPlay")
        newGameIcon.name = "New Game"
        newGameIcon.size = CGSize(width: 32, height: 32)
        newGameIcon.zPosition = GameConstants.ZPositions.Icon
        newGameIcon.position = CGPoint(x: -50, y: mainMenu.frame.midY + 40)
        */

        if let ResumeGameButton = mainMenu.childNode(withName: "ResumeGameButton") as? SKSpriteNode {
            resumeGameButton = ResumeGameButton
        } else {
            print("resume game button not found")
        }

        /*
        resumeGameIcon.texture = SKTexture(imageNamed: "GreenReload")
        resumeGameIcon.name = "Continue"
        resumeGameIcon.size = CGSize(width: 32, height: 32)
        resumeGameIcon.zPosition = GameConstants.ZPositions.Icon
        resumeGameIcon.position = CGPoint(x: -50, y: mainMenu.frame.midY)
        
        */

        if let SettingsButton = mainMenu.childNode(withName: "SettingsButton") as? SKSpriteNode {
            settingsButton = SettingsButton
        } else {
            print("settings button not found")
        }

        /*
        settingsIcon.texture = SKTexture(imageNamed: "GreenSettings")
        settingsIcon.name = "Settings"
        settingsIcon.size = CGSize(width: 32, height: 32)
        settingsIcon.zPosition = GameConstants.ZPositions.Icon
        settingsIcon.position = CGPoint(x: -50, y: mainMenu.frame.midY - 40)
        */

        if let ExitButton = mainMenu.childNode(withName: "ExitButton") as? SKSpriteNode {
            exitButton = ExitButton
        } else {
            print("exit button not found")
        }
        /*
        exitIcon.texture = SKTexture(imageNamed: "GreenExit")
        exitIcon.name = "Exit"
        exitIcon.size = CGSize(width: 32, height: 32)
        exitIcon.zPosition = GameConstants.ZPositions.Icon
        exitIcon.position = CGPoint(x: -50, y: mainMenu.frame.midY - 80)
        */

        if let InfoButton = mainMenu.childNode(withName: "InfoButton") as? SKSpriteNode {
            infoButton = InfoButton
        } else {
            print("info button not found")
        }

        /*
        infoIcon.texture = SKTexture(imageNamed: "GreenInfo")
        infoIcon.name = "Info"
        infoIcon.size = CGSize(width: 24, height: 24)
        infoIcon.position = CGPoint(x: mainMenu.frame.maxX - 50, y: mainMenu.frame.minY + 35)
        infoIcon.zPosition = GameConstants.ZPositions.Icon
        */

        //setupMainMenuLabels()
        setupMainMenuButtonsArray()
        //addMainMenu()
    }
    
    func setupMainMenuLabels() {
        mainMenuLabel.text = "Main Menu"
        mainMenuLabel.fontName = GameConstants.StringConstants.FontName
        mainMenuLabel.fontSize = GameConstants.Sizes.MainMenuFont
        mainMenuLabel.fontColor = GameConstants.Colors.MainMenuFont
        mainMenuLabel.zPosition = GameConstants.ZPositions.MenuLabel
        mainMenuLabel.position = CGPoint(x: 0, y: mainMenu.frame.maxY - (mainMenuLabel.fontSize + (mainMenuLabel.fontSize / 3)))
        
        newGameButtonLabel.text = "New Game"
        newGameButtonLabel.fontName = GameConstants.StringConstants.FontName
        newGameButtonLabel.fontSize = GameConstants.Sizes.IconLabelFont
        newGameButtonLabel.fontColor = GameConstants.Colors.IconLabelFont
        newGameButtonLabel.zPosition = GameConstants.ZPositions.IconLabel
        newGameButtonLabel.position = CGPoint(x: 65, y: -8)
        
        resumeButtonLabel.text = "Continue"
        resumeButtonLabel.fontName = GameConstants.StringConstants.FontName
        resumeButtonLabel.fontSize = GameConstants.Sizes.IconLabelFont
        resumeButtonLabel.fontColor = GameConstants.Colors.IconLabelFont
        resumeButtonLabel.zPosition = GameConstants.ZPositions.IconLabel
        resumeButtonLabel.position = CGPoint(x: 59, y: -8)
        
        settingsButtonLabel.text = "Settings"
        settingsButtonLabel.fontName = GameConstants.StringConstants.FontName
        settingsButtonLabel.fontSize = GameConstants.Sizes.IconLabelFont
        settingsButtonLabel.fontColor = GameConstants.Colors.IconLabelFont
        settingsButtonLabel.zPosition = GameConstants.ZPositions.IconLabel
        settingsButtonLabel.position = CGPoint(x: 58, y: -8)
        
        exitButtonLabel.text = "Exit Game"
        exitButtonLabel.fontName = GameConstants.StringConstants.FontName
        exitButtonLabel.fontSize = GameConstants.Sizes.IconLabelFont
        exitButtonLabel.fontColor = GameConstants.Colors.IconLabelFont
        exitButtonLabel.zPosition = GameConstants.ZPositions.IconLabel
        exitButtonLabel.position = CGPoint(x: 67, y: -8)
    }
    
    func setupSettingsMenuButtons() {
        if let SoundButton = settingsMenu.childNode(withName: "SoundButton") as? SKSpriteNode {
            soundButton = SoundButton
        } else {
            print("sound button not found")
        }
        /*
        soundIcon.texture = SKTexture(imageNamed: "GreenSound")
        soundIcon.name = "Sound"
        soundIcon.size = CGSize(width: 32, height: 32)
        soundIcon.zPosition = GameConstants.ZPositions.Icon
        soundIcon.position = CGPoint(x: -50, y: settingsMenu.frame.midY + 40)
        */

        if let BackButton = settingsMenu.childNode(withName: "BackButton") as? SKSpriteNode {
            backButton = BackButton
        } else {
            print("back button not found")
        }
        /*
        backButton.texture = SKTexture(imageNamed: "GreenLeftArrow")
        backButton.name = "Back"
        backButton.size = CGSize(width: 32, height: 32)
        backButton.zPosition = GameConstants.ZPositions.Icon
        backButton.position = CGPoint(x: -50, y: settingsMenu.frame.midY)
        */
        //setupSettingsMenuLabels()
        setupSettingsMenuButtonsArray()
    }
    
    func setupSettingsMenuLabels() {
        settingsMenuLabel.text = "Settings Menu"
        settingsMenuLabel.fontName = GameConstants.StringConstants.FontName
        settingsMenuLabel.fontSize = GameConstants.Sizes.MainMenuFont
        settingsMenuLabel.fontColor = GameConstants.Colors.MainMenuFont
        settingsMenuLabel.zPosition = GameConstants.ZPositions.MenuLabel
        settingsMenuLabel.position = CGPoint(x: 0, y: settingsMenu.frame.maxY - (settingsMenuLabel.fontSize + (settingsMenuLabel.fontSize / 3)))
        soundButtonLabel.text = "Sound"
        soundButtonLabel.fontName = GameConstants.StringConstants.FontName
        soundButtonLabel.fontSize = GameConstants.Sizes.IconLabelFont
        soundButtonLabel.fontColor = GameConstants.Colors.IconLabelFont
        soundButtonLabel.zPosition = GameConstants.ZPositions.IconLabel
        soundButtonLabel.position = CGPoint(x: 65, y: -8)
        
        backButtonLabel.text = "Back"
        backButtonLabel.fontName = GameConstants.StringConstants.FontName
        backButtonLabel.fontSize = GameConstants.Sizes.IconLabelFont
        backButtonLabel.fontColor = GameConstants.Colors.IconLabelFont
        backButtonLabel.zPosition = GameConstants.ZPositions.IconLabel
        backButtonLabel.position = CGPoint(x: 59, y: -8)
    }
    
    func addMainMenu() {
        
        self.addChild(mainMenu)
        mainMenu.addChild(newGameButton)
        mainMenu.addChild(resumeGameButton)
        mainMenu.addChild(settingsButton)
        mainMenu.addChild(exitButton)
        mainMenu.addChild(infoButton)
        newGameButton.addChild(newGameButtonLabel)
        resumeGameButton.addChild(resumeButtonLabel)
        settingsButton.addChild(settingsButtonLabel)
        exitButton.addChild(exitButtonLabel)
    }
    
    func addSettingsMenu() {
        self.addChild(settingsMenu)
        settingsMenu.addChild(soundButton)
        soundButton.addChild(soundButtonLabel)
        settingsMenu.addChild(backButton)
        backButton.addChild(backButtonLabel)
    }
}
