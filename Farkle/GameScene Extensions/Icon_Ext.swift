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
        ReloadIcon.name = "Restart Icon"
        
        SettingsIcon = SKSpriteNode(imageNamed: "GreenSettings")
        SettingsIcon.name = "Settings Icon"
        
        HomeIcon = SKSpriteNode(imageNamed: "GreenHome")
        HomeIcon.name = "Home Icon"
        
        setupIconsArray()
        setupIconWindowIconsArray()
        
        /*
         for icon in Icons {
         icon.size = GameConstants.Icon.Size
         icon.isUserInteractionEnabled = true
         icon.zPosition = GameConstants.ZPositions.Icon
         
         switch icon.name {
         case "Play Icon":
         icon.position = CGPoint(x: 100, y: 100)
         PlayIcon.position = icon.position
         case "Exit Icon":
         icon.position = CGPoint(x: frame.maxX - 40, y: frame.maxY - 10)
         ExitIcon.position = icon.position
         case "Pause Icon":
         icon.position = CGPoint(x: frame.maxX - 10, y: frame.maxY - 50)
         PauseIcon.position = icon.position
         case "Sound Icon":
         icon.position = CGPoint(x: frame.maxX - 10, y: frame.minY + 10)
         SoundIcon.position = icon.position
         case "Info Icon":
         icon.position = CGPoint(x: frame.maxX - 40, y: frame.minY + 10)
         InfoIcon.position = icon.position
         default:
         break
         }
         }
         */
    }
    
    func setupIconsArray() {
        Icons = [PlayIcon, PauseIcon, ExitIcon, MenuIcon, SoundIcon, ReloadIcon, HomeIcon, SettingsIcon, InfoIcon]
    }
    
    func setupIconWindowIconsArray() {
        IconWindowIcons = [PlayIcon, PauseIcon, ExitIcon, MenuIcon, SoundIcon]
    }

    func addIconWindowIcons() {
        for icon in IconWindowIcons {
            IconWindow.addChild(icon)
        }
    }
    
    func addIcons() {
        for icon in Icons {
            icon.zPosition = GameConstants.ZPositions.Icon
            IconWindow.addChild(icon)
        }
    }
}
