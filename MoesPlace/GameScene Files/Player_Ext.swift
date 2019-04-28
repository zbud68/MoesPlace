//
//  Player_Ext.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

extension GameScene {

    func setupPlayers() {
        player1.name = "Player 1"
        player2.name = "Player 2"
        player3.name = "Player 3"
        player4.name = "Player 4"

        player1.nameLabel.text = player1.name
        player2.nameLabel.text = player2.name
        player3.nameLabel.text = player3.name
        player4.nameLabel.text = player4.name
        
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
            break
        }
        
        if let Player1ScoreLabel = scoresWindow.childNode(withName: "Player1ScoreLabel") as? SKLabelNode {
            player1.scoreLabel = Player1ScoreLabel
        }
        if let Player2ScoreLabel = scoresWindow.childNode(withName: "Player2ScoreLabel") as? SKLabelNode {
            player2.scoreLabel = Player2ScoreLabel
        }
        if let Player3ScoreLabel = scoresWindow.childNode(withName: "Player3ScoreLabel") as? SKLabelNode {
            player3.scoreLabel = Player3ScoreLabel
        }
        if let Player4ScoreLabel = scoresWindow.childNode(withName: "Player4ScoreLabel") as? SKLabelNode {
            player4.scoreLabel = Player4ScoreLabel
        }

        for player in playersArray {
            //player.name = player.nameLabel.text!
            player.scoreLabel.text = String(player.score)
            scoresWindow.addChild(player.nameLabel)
            scoresWindow.addChild(player.scoreLabel)
        }

        currentPlayer = playersArray.first
        positionPlayerLabels()
    }
    
    func positionPlayerLabels() {
        for player in playersArray {
            player.nameLabel.fontName = GameConstants.StringConstants.FontName
            player.scoreLabel.fontName = GameConstants.StringConstants.FontName
            player.nameLabel.fontSize = GameConstants.Sizes.PlayerNameLabelFont
            player.scoreLabel.fontSize = GameConstants.Sizes.PlayerScoreLabelFont
            player.nameLabel.fontColor = GameConstants.Colors.PlayerNameLabelFont
            player.scoreLabel.fontColor = GameConstants.Colors.PlayerScoreLabelFont
            player.nameLabel.zPosition = GameConstants.ZPositions.NameLabel
            player.scoreLabel.zPosition = GameConstants.ZPositions.ScoreLabel
            
            switch player.name {
            case "Player 1":
                player1.nameLabel.position = CGPoint(x: 0, y: (scoresWindow.frame.height / 4) + 15)
                
                player1.scoreLabel.position = CGPoint(x: player1.nameLabel.position.x, y: player1.nameLabel.position.y - 30)
            case "Player 2":
                player2.nameLabel.position = CGPoint(x: 0, y: player1.nameLabel.position.y - 60)
                
                player2.scoreLabel.position = CGPoint(x: player1.nameLabel.position.x, y: player2.nameLabel.position.y - 30)
            case "Player 3":
                player3.nameLabel.position = CGPoint(x: 0, y: player2.nameLabel.position.y - 60)
                
                player3.scoreLabel.position = CGPoint(x: player2.nameLabel.position.x, y: player3.nameLabel.position.y - 30)
            case "Player 4":
                player4.nameLabel.position = CGPoint(x: 0, y: player3.nameLabel.position.y - 60)
                
                player4.scoreLabel.position = CGPoint(x: player3.nameLabel.position.x, y: player4.nameLabel.position.y - 25)
            default:
                break
            }
        }
    }
}
