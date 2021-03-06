//
//  UIAlerts.swift
//  MoesPlace
//
//  Created by Mark Davis on 4/9/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import UIKit
import SpriteKit

extension GameScene {
    
    func gameInProgressMessage(on scene: SKScene, title: String, message: String) {
        let alert = UIAlertController(title: "Game In Progress", message: GameConstants.Messages.GameInProgress, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: .destructive, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            self.gameState = .NewGame
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        scene.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func noGameInProgessMessage(on scene: SKScene, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil) }))
        
        scene.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func gameOverMessage(on scene: SKScene, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil) }))
        
        scene.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func farkleMessage(on scene: SKScene, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil) }))
        
        scene.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }

}

