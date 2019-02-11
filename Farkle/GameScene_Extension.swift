//
//  GameScene_Extension.swift
//  Farkle
//
//  Created by Mark Davis on 2/6/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

extension GameScene {
    
    //MARK: ********** Touches Section **********
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            iconTouchLocation = touch.location(in: IconWindow)
            touchLocation = touch.location(in: self)
            print("touch location: \(touchLocation)")
        }
        wasIconTouched()
    }

    func wasIconTouched() {
        for icon in Icons {
            print("icon name: \(icon.name!)")
            print("icon position: \(icon.position)")
            print("icon Touch Location: \(iconTouchLocation)")
            print("touch location: \(touchLocation)")
            if icon.contains(iconTouchLocation) {
                print(icon.position)
                print(icon.name!)
                iconWasTouched(icon: icon.name!)
            }
        }
    }

    func iconWasTouched(icon: String) {
        let Icon = icon
        switch Icon {
        case "PlayIcon":
            playIconTouched()
        case "SettingsIcon":
            print("Settings Icon Touched")
        case "HelpIcon":
            print("Help Icon Touched")
        case "PauseIcon":
            print("pause icon touched")
        case "ExitIcon":
            print("exit icon touched")
        case "SoundIcon":
            print("sound icon touched")
        case "InfoIcon":
            print("Info icon touched")
        case "MenuIcon":
            print("menu icon touched")
        case "HomeIcon":
            print("Home icon touched")
        case "BackIcon":
            print("back icon touched")
        case "ToggleSwitchOff":
            print("toggle switch touched")
        default:
            print("no icon was touched")
        }
    }
    
    func playIconTouched() {
        print("Play Icon Touched")
    }
}

