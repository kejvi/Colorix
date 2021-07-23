//
//  GameModel.swift
//  Colorix
//
//  Created by Kejvi Peti on 2021-07-22.
//

import SpriteKit
import UIKit


class GameModel {
    
    static func getLabel(with frame: CGRect) -> SKSpriteNode {
        let colorSwitch = SKSpriteNode(imageNamed: "ColorCircle")
        colorSwitch.size = CGSize(width: frame.size.width/3, height: frame.size.width/3)
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY + colorSwitch.size.height)
        colorSwitch.zPosition = ZPositions.colorSwitch
        
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.width/2)
        colorSwitch.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory
        colorSwitch.physicsBody?.isDynamic = false
        return colorSwitch
    }
    
    static func getScoreLabel(with frame: CGRect) -> SKLabelNode {
        let scoreLabel = SKLabelNode(text: "0")
        scoreLabel.fontName = "AvenirNext-Bold"
        scoreLabel.fontSize = 60.0
        scoreLabel.color = UIColor.white
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        scoreLabel.zPosition = ZPositions.label
        return scoreLabel
    }
    
    static func getBall(with frame: CGRect, index: Int) -> SKSpriteNode{
        let ball = SKSpriteNode(
            texture: SKTexture(imageNamed: "ball"),
            color: PlayColors.colors[index],
            size: CGSize(width: 30.0, height: 30.0)
        )
        ball.colorBlendFactor = 1.0
        ball.position = CGPoint(x: frame.midX, y: frame.maxY)
        ball.zPosition = ZPositions.ball
        ball.name = "Ball"
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory
        ball.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory
        ball.physicsBody?.collisionBitMask = PhysicsCategories.none
        return ball
    }
    
}
