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
        
        player1.Roll.diceRemaining = currentGame.numDice
        player2.Roll.diceRemaining = currentGame.numDice
        player3.Roll.diceRemaining = currentGame.numDice
        player4.Roll.diceRemaining = currentGame.numDice
        
        player1.name = GameConstants.StringConstants.player1Name
        player2.name = GameConstants.StringConstants.player2Name
        player3.name = GameConstants.StringConstants.player3Name
        player4.name = GameConstants.StringConstants.player4Name
        
        player1.Label.nameLabel.text = player1.name
        player2.Label.nameLabel.text = player2.name
        player3.Label.nameLabel.text = player3.name
        player4.Label.nameLabel.text = player4.name
        
        setupPlayersArray()
        setupPlayerScoreLabels()
    }
    
    func setupPlayersArray() {
        switch currentGame.numPlayers {
        case 1:
            players = [player1]
        case 2:
            players = [player1, player2]
        case 3:
            players = [player1, player2, player3]
        case 4:
            players = [player1, player2, player3, player4]
        default:
            players = [player1]
        }
    }
    
    func setupPlayerScoreLabels() {
        
        player1.score = 10000
        player2.score = 1000
        player3.score = 2341
        player4.score = 9993
        
        player1.Label.scoreLabel.text = String(player1.score)
        player2.Label.scoreLabel.text = String(player2.score)
        player3.Label.scoreLabel.text = String(player3.score)
        player4.Label.scoreLabel.text = String(player4.score)
        
        for player in players {
            player.Label.nameLabel.fontName = GameConstants.PlayerNameLabel.FontName
            player.Label.nameLabel.fontColor = GameConstants.PlayerNameLabel.FontColor
            player.Label.nameLabel.fontSize = GameConstants.PlayerNameLabel.FontSize
            player.Label.nameLabel.zPosition = scoresWindow.zPosition + 1
            
            player.Label.scoreLabel.fontName = GameConstants.PlayerScoreLabel.FontName
            player.Label.scoreLabel.fontColor = GameConstants.PlayerScoreLabel.FontColor
            player.Label.scoreLabel.fontSize = GameConstants.PlayerScoreLabel.FontSize
            player.Label.scoreLabel.zPosition = scoresWindow.zPosition + 1
            print("player name label: \(player.Label.nameLabel.text!)")
            print("player score label: \(player.Label.scoreLabel.text!)")
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
        /*
        for player in players {
            print("player name: \(player.name!)")
            scoresWindow.addChild(player.nameLabel)
            scoresWindow.addChild(player.scoreLabel)
        }
        */
    }
}
