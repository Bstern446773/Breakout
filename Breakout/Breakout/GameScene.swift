//
//  GameScene.swift
//  Breakout
//
//  Created by Bennett Stern on 3/18/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var ball = SKShapeNode()
    var paddle = SKSpriteNode()
    var brick = SKSpriteNode ()
    
    override func didMove(to view: SKView) {
        // this stuff happens once (when the app opens)
        createBackground()
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        resetGame()
    }
    
    func kickBall() {
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 5))
    }
    func resetGame() {
        // this stuff happens before each game starts
        makeBall()
        func makePaddle() {
            paddle.removeFromParent()  // remove the paddle, if it exists
            paddle = SKSpriteNode(color: .blue, size: CGSize(width: 50, height: 20))
            paddle.position = CGPoint(x: frame.midX, y: frame.minY + 25)
            paddle.name = "brick"
            paddle.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
            paddle.physicsBody?.isDynamic = false
            addChild(paddle)
    }
    
    func createBackground() {
        let stars = SKTexture (imageNamed: "Stars")
        for i in 0...1 {
            let starsBackground = SKSpriteNode (texture: stars)
            starsBackground.zPosition = -1
            starsBackground.position = CGPoint(x: 0, y: starsBackground.size.height * CGFloat (i))
            addChild(starsBackground)
            let moveDown = SKAction.moveBy(x: 0, y: -starsBackground.size.height, duration: 20)
            let moveReset = SKAction.moveBy(x: 0, y: starsBackground.size.height, duration: 0)
            let moveloop = SKAction.sequence([moveDown, moveReset])
            let moveForever = SKAction.repeatForever(moveloop)
            starsBackground.run(moveForever)
        }
    }
    
    func makeBall() {
        ball.removeFromParent()    // remove the ball (if it exists)
        ball = SKShapeNode(circleOfRadius: 10)
        ball.position = CGPoint(x: frame.midX, y: frame.midY)
        ball.strokeColor = .black
        ball.fillColor = .yellow
        ball.name = "ball"
        
        //physics shape matches ball image
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        // ignores all forces and impulses
        ball.physicsBody?.isDynamic = false
        // use precise collision detection
        ball.physicsBody?.usesPreciseCollisionDetection = true
        // no loss of energy from friction
        ball.physicsBody?.friction = 0
        // gravity is not a factor
        ball.physicsBody?.affectedByGravity = false
        // bounces fully off of other objects
        ball.physicsBody?.restitution = 1
        // does not slow down over time
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.contactTestBitMask = (ball.physicsBody?.collisionBitMask)!
        
        addChild(ball) // add ball object to the view
        
        
        
        }
    }
}
func makeBrick() {
    brick.removeFromParent()   //remove the brick, if it exists
    brick = SKSpriteNode(color: .blue, size: CGSize(width: 50, height: 20))
    brick.position = CGPoint(x: frame.midX, y: frame.maxY - 50)
    brick.name = "brick"
    brick.physicsBody = SKPhysicsBody (rectangleOf: brick.size)
    brick.physicsBody?.isDynamic = false
    addChild(brick)
}
