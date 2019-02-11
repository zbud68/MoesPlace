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
        PlayIcon = SKSpriteNode(imageNamed: "GreenPlay")
        PlayIcon.name = "Play Icon"
        
        ExitIcon = SKSpriteNode(imageNamed: "GreenExit")
        ExitIcon.name = "Exit Icon"
        
        SoundIcon = SKSpriteNode(imageNamed: "GreenSound")
        SoundIcon.name = "Sound Icon"
        
        InfoIcon = SKSpriteNode(imageNamed: "GreenInfo")
        InfoIcon.name = "Info Icon"
        
        MenuIcon = SKSpriteNode(imageNamed: "GreenMenu")
        MenuIcon.name = "Menu Icon"
        
        PauseIcon = SKSpriteNode(imageNamed: "GreenPause")
        PauseIcon.name = "Pause Icon"
        
        ReloadIcon = SKSpriteNode(imageNamed: "GreenReload")
        ReloadIcon.name = "Reload Icon"
        
        SettingsIcon = SKSpriteNode(imageNamed: "GreenSettings")
        SettingsIcon.name = "Settings Icon"
        
        HomeIcon = SKSpriteNode(imageNamed: "GreenHome")
        HomeIcon.name = "Home Icon"
        
        iconWidth = PlayIcon.size.width
        iconHeight = PlayIcon.size.height
        
        setupIconsArray()
        setupIconWindowIconsArray()
        
        positionIconWindowIcons()
        addIconWindowIcons()
    }
    
    func positionIconWindowIcons() {
        
        for icon in IconWindowIcons {
            icon.zPosition = IconWindow.zPosition + 1
            icon.size = CGSize(width: 30, height: 30)
            switch icon.name {
            case "Play Icon":
                icon.position = CGPoint(x: (icon.size.width / 2) - (IconWindow.size.width / 3) + 3, y: (icon.size.height / 2) + (IconWindow.size.height / 4) - 20)
                PlayIcon.position = icon.position
            case "Pause Icon":
                icon.position = CGPoint(x: PlayIcon.position.x + 35, y: PlayIcon.position.y)
                PauseIcon.position = icon.position
            case "Reload Icon":
                icon.position = CGPoint(x: PauseIcon.position.x + 35, y: PauseIcon.position.y)
                ReloadIcon.position = icon.position
            case "Menu Icon":
                icon.position = CGPoint(x: (PlayIcon.position.x + (icon.size.width / 2)), y: (PlayIcon.position.y - icon.size.height) - 5)
                MenuIcon.position = icon.position
            case "Exit Icon":
                icon.position = CGPoint(x: MenuIcon.position.x + 35, y: MenuIcon.position.y)
                ExitIcon.position = icon.position
            default:
                break
            }
        }
    }
    
    func setupIconsArray() {
        Icons = [PlayIcon, PauseIcon, ExitIcon, MenuIcon, SoundIcon, ReloadIcon, HomeIcon, SettingsIcon, InfoIcon]
    }
    
    func setupIconWindowIconsArray() {
        IconWindowIcons = [PlayIcon, PauseIcon, ReloadIcon, MenuIcon, ExitIcon]
    }

    func addIconWindowIcons() {
        for icon in IconWindowIcons {
            switch icon.name {
            case "Play Icon":
                IconWindow.addChild(icon)
            case "Pause Icon":
                IconWindow.addChild(icon)
            case "Reload Icon":
                IconWindow.addChild(icon)
            case "Menu Icon":
                IconWindow.addChild(icon)
            case "Exit Icon":
                IconWindow.addChild(icon)
            default:
                break
            }
        }
    }
}
