//
//  GameScene.swift
//  Colorix
//
//  Created by Kejvi Peti on 2021-07-22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var colorSwitch: SKSpriteNode!
    var switchState = SwitchState.red
    var currentColorIndex: Int?
    var gravity = -2.0
    var level = 0
    
    var scoreLabel = SKLabelNode(text: "0")
    var score = 0
    
    override func didMove(to view: SKView) {
        
        run(SKAction.playSoundFileNamed("woosh", waitForCompletion: false))
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: gravity)
        physicsWorld.contactDelegate = self
        
        backgroundColor = Colors.levelColor[level]
        colorSwitch = GameModel.getLabel(with: frame)
        addChild(colorSwitch)
        
        scoreLabel = GameModel.getScoreLabel(with: frame)
        addChild(scoreLabel)
        
        spawnBall()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        turnWheel()
    }
    
    func updateScore(){
        score += 1
        scoreLabel.text = "\(score)"
        if score % 5 == 0 {
           updateWorld()
        }
    }
    
    func updateWorld(){
        gravity -= 1
        physicsWorld.gravity = CGVector(dx: 0.0, dy: gravity)
        
        level = (level == 3 ) ? 0 : level + 1
        self.run(SKAction.colorize(with: Colors.levelColor[level], colorBlendFactor: 0, duration: 0.3))
    }
    
    func spawnBall(){
        currentColorIndex = Int(arc4random_uniform(UInt32(4)))
        let ball = GameModel.getBall(with: frame, index: currentColorIndex!)
        addChild(ball)
    }
    
    func turnWheel(){
        if let newState = SwitchState(rawValue: switchState.rawValue + 1){
            switchState = newState
        }else{
            switchState = .red
        }
        colorSwitch.run(SKAction.rotate(byAngle: .pi/2, duration: 0.25))
    }
    
    func gameOver(){
        UserDefaults.standard.set(score, forKey: "recentScore")
        if score > UserDefaults.standard.integer(forKey: "highScore"){
            UserDefaults.standard.set(score, forKey: "highscore")
        }
        let menuScene = MenuScene(size: view!.bounds.size)
        view!.presentScene(menuScene)
    }
}

extension GameScene : SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contactMask == PhysicsCategories.ballCategory | PhysicsCategories.switchCategory {
            if let ball = contact.bodyA.node?.name == "Ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode{
                if currentColorIndex == switchState.rawValue {
                    run(SKAction.playSoundFileNamed("bling", waitForCompletion: false))
                    updateScore()
                    ball.run(SKAction.fadeOut(withDuration: 0.25), completion:{
                        ball.removeFromParent()
                        self.spawnBall()
                    })
                }else{
                    run(SKAction.playSoundFileNamed("game_over", waitForCompletion: true)){
                        self.gameOver()
                    }
                }
            }
        }
    }
    
}

enum PlayColors {
    static let colors = [
        UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0),
        UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1.0),
        UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0),
        UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
    ]
}

enum SwitchState: Int {
    case red, yellow, green, blue
}
