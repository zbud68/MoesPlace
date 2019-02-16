//
//  Popup_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

extension GameScene {
    func setupMenuLabel(labelName: String) {
        label = SKLabelNode(text: labelName)
        label.fontName = GameConstants.Logo.FontName
        label.fontColor = GameConstants.Logo.FontColor
        label.fontSize = GameConstants.Logo.FontSize2
        label.zPosition = GameConstants.ZPositions.Message
        label.name = "\(label) Label"
        label.position = CGPoint(x: mainMenu.position.x, y: ((mainMenu.position.y) + (mainMenu.size.height / 2)) - 40)
    }

    func addWindows() {

    }

    func addMenus() {

    }
}
