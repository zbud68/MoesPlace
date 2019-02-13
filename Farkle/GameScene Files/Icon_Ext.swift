//
//  Icon_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    func setupIcons() {
        playIcon = SKSpriteNode(imageNamed: "GreenPlay")
        playIcon.name = "Play Icon"

        exitIcon = SKSpriteNode(imageNamed: "GreenExit")
        exitIcon.name = "Exit Icon"

        soundIcon = SKSpriteNode(imageNamed: "GreenSound")
        soundIcon.name = "Sound Icon"

        infoIcon = SKSpriteNode(imageNamed: "GreenInfo")
        infoIcon.name = "Info Icon"

        menuIcon = SKSpriteNode(imageNamed: "GreenMenu")
        menuIcon.name = "Menu Icon"

        pauseIcon = SKSpriteNode(imageNamed: "GreenPause")
        pauseIcon.name = "Pause Icon"

        reloadIcon = SKSpriteNode(imageNamed: "GreenReload")
        reloadIcon.name = "Reload Icon"

        settingsIcon = SKSpriteNode(imageNamed: "GreenSettings")
        settingsIcon.name = "Settings Icon"

        homeIcon = SKSpriteNode(imageNamed: "GreenHome")
        homeIcon.name = "Home Icon"

        iconWidth = playIcon.size.width
        iconHeight = playIcon.size.height

        setupIconsArray()
        setupIconWindowIconsArray()

        positionIconWindowIcons()
        addIconWindowIcons()
    }

    func positionIconWindowIcons() {
        for icon in iconWindowIcons {
            icon.zPosition = GameConstants.ZPositions.Icon
            icon.size = CGSize(width: 30, height: 30)
            switch icon.name {
                case "Play Icon":
                    icon.position = CGPoint(x: (icon.size.width / 2) - (iconWindow.size.width / 3) + 3, y: (icon.size.height / 2) + (iconWindow.size.height / 4) - 20)
                    playIcon.position = icon.position
                case "Pause Icon":
                    icon.position = CGPoint(x: playIcon.position.x + 35, y: playIcon.position.y)
                    pauseIcon.position = icon.position
                case "Reload Icon":
                    icon.position = CGPoint(x: pauseIcon.position.x + 35, y: pauseIcon.position.y)
                    reloadIcon.position = icon.position
                case "Menu Icon":
                    icon.position = CGPoint(x: (playIcon.position.x + (icon.size.width / 2)), y: (playIcon.position.y - icon.size.height) - 5)
                    menuIcon.position = icon.position
                case "Settings Icon":
                    icon.position = CGPoint(x: menuIcon.position.x + 35, y: menuIcon.position.y)
                    settingsIcon.position = icon.position
                default:
                    break
            }
        }
    }

    func setupIconsArray() {
        icons = [playIcon, pauseIcon, exitIcon, menuIcon, soundIcon, reloadIcon, homeIcon, settingsIcon, infoIcon]
    }

    func setupIconWindowIconsArray() {
        iconWindowIcons = [playIcon, pauseIcon, reloadIcon, menuIcon, settingsIcon]
    }

    func addIconWindowIcons() {
        for icon in iconWindowIcons {
            switch icon.name {
                case "Play Icon":
                    iconWindow.addChild(icon)
                case "Pause Icon":
                    iconWindow.addChild(icon)
                case "Reload Icon":
                    iconWindow.addChild(icon)
                case "Menu Icon":
                    iconWindow.addChild(icon)
                case "Settings Icon":
                    iconWindow.addChild(icon)
                default:
                    break
            }
        }
    }
}
