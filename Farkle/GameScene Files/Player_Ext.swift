//
//  Player_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

extension GameScene {

    func setupPlayers() {
        player1.nameLabel.text = "Player 1"
        player2.nameLabel.text = "Player 2"
        player3.nameLabel.text = "Player 3"
        player4.nameLabel.text = "Player 4"
        
        switch currentGame.numPlayers {
        case 1:
            playersArray = [player1]
        case 2:
            playersArray = [player1, player2]
        case 3:
            playersArray = [player1, player2, player3]
        case 4:
            playersArray = [player1, player2, player3, player4]
        default:
            playersArray = [player1, player2]
        }
        for player in playersArray {
            player.scoreLabel.text = String(player.score)
            player.name = player.nameLabel.text!
        }
        for player in playersArray {
            print("player name: \(player.name)")
            print("player score: \(player.scoreLabel.text!)")
        }
        positionPlayerLabels()
        for player in playersArray {
            scoresWindow.addChild(player.nameLabel)
            scoresWindow.addChild(player.scoreLabel)
        }
    }
    
    func positionPlayerLabels() {
        
        
    }
}

        /*
            switch player.name {
            case "Player 1":
                player.Label.nameLabel.position = CGPoint(x: 0, y: (scoresWindow.frame.height / 4) + 15)
                player1.Label.nameLabel.position = player.Label.nameLabel.position
                
                player.Label.scoreLabel.position = CGPoint(x: player.Label.nameLabel.position.x, y: player.Label.nameLabel.position.y - 30)
                player1.Label.scoreLabel.position = player.Label.scoreLabel.position
                
                player1.Label.nameLabel = player.Label.nameLabel
                
            case "Player 2":
                player.Label.nameLabel.position = CGPoint(x: 0, y: player1.Label.nameLabel.position.y - 60)
                player2.Label.nameLabel.position = player.Label.nameLabel.position
                
                player.Label.scoreLabel.position = CGPoint(x: player1.Label.nameLabel.position.x, y: player2.Label.nameLabel.position.y - 30)
                player2.Label.scoreLabel.position = player.Label.scoreLabel.position
                player2.Label.nameLabel = player.Label.nameLabel

            case "Player 3":
                player.Label.nameLabel.position = CGPoint(x: 0, y: player2.Label.nameLabel.position.y - 60)
                player3.Label.nameLabel.position = player.Label.nameLabel.position
                
                player.Label.scoreLabel.position = CGPoint(x: player2.Label.nameLabel.position.x, y: player3.Label.nameLabel.position.y - 30)
                player3.Label.scoreLabel.position = player.Label.scoreLabel.position
                player3.Label.nameLabel = player.Label.nameLabel

            case "Player 4":
                player.Label.nameLabel.position = CGPoint(x: 0, y: player3.Label.nameLabel.position.y - 60)
                player4.Label.nameLabel.position = player.Label.nameLabel.position
                
                player.Label.scoreLabel.position = CGPoint(x: player3.Label.nameLabel.position.x, y: player4.Label.nameLabel.position.y - 25)
                player4.Label.scoreLabel.position = player.Label.scoreLabel.position
                player4.Label.nameLabel = player.Label.nameLabel

            default:
                break
            }
            scoresWindow.addChild(player.Label.nameLabel)
            scoresWindow.addChild(player.Label.scoreLabel)
        }
        
        for player in players {
            print("player name: \(player.name!)")
            scoresWindow.addChild(player.nameLabel)
            scoresWindow.addChild(player.scoreLabel)
        }*/
