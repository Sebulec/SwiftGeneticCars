//
//  GameScene.swift
//  GeneticCars
//
//  Created by Sebastian Kotarski on 25.10.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var circle: SKShapeNode?
    let cam = SKCameraNode()
    
    let arrowCategory: UInt32 = 0x1 << 0
    let ballCategory: UInt32 = 0x1 << 1
    private var isAddingNewPlatforms: Bool = false
    
    private var platformsGenerator: PlatformsGenerator?
    
    override func didMove(to view: SKView) {
        configureViews()
        self.addChild(getCircle())
        self.platformsGenerator = PlatformsGenerator(startingPoint: CGPoint(x: 0, y: 0))
        platformsGenerator?.dificulty = 75
        platformsGenerator?.numberOfPlatforms = 200
        let platforms = platformsGenerator?.generatePlatformsFrom()
        
        platforms?.forEach({self.addChild($0)})
    }
    
    func getCircle() -> SKShapeNode {
        circle = SKShapeNode(circleOfRadius: 10)
        circle?.position.x = 100
        circle?.position.y = 100
        circle?.fillColor = UIColor.red
        circle?.zPosition = 1
        circle?.lineWidth = 0
        circle?.lineCap = CGLineCap(rawValue: 1)!
        circle?.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        circle?.physicsBody?.isDynamic = true
        circle?.physicsBody?.restitution = 0.7
        circle?.physicsBody?.friction = 0.5
        circle?.physicsBody?.usesPreciseCollisionDetection = true
        circle?.physicsBody?.allowsRotation = true
        
        let line = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 2, height: 10))
        line.fillColor = UIColor.white
        line.lineWidth = 1
        circle?.addChild(line)
        circle?.physicsBody?.affectedByGravity = true
        
        //        let action = SKAction.repeatForever(SKAction.rotate(byAngle: .pi/4, duration: 1/20))
        
        return circle!
    }
    
    func getAnotherPlatformToExisting(existingPlatform: SKSpriteNode) -> SKSpriteNode {
        let newRectangle = SKSpriteNode.init(imageNamed: "grass")
        newRectangle.size = existingPlatform.size
        newRectangle.zPosition = existingPlatform.zPosition
        newRectangle.zRotation = .pi/4
        newRectangle.position.x = existingPlatform.position.x + existingPlatform.size.width
        newRectangle.position.y = existingPlatform.position.y
        newRectangle.physicsBody = SKPhysicsBody(rectangleOf: newRectangle.size)
        newRectangle.name = existingPlatform.name
        newRectangle.physicsBody?.friction = (existingPlatform.physicsBody?.friction)!
        newRectangle.physicsBody?.isDynamic = true
        newRectangle.physicsBody?.mass = 2
        newRectangle.physicsBody?.affectedByGravity = true
        return newRectangle
    }
    
    func configureViews() {
        self.scene?.size = (view?.bounds.size)!
        self.view?.backgroundColor = UIColor.white
        self.backgroundColor = UIColor.white
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        self.physicsWorld.contactDelegate = self
        self.scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.showsPhysics = true
        self.camera = cam
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if let circle = self.circle {
            cam.position = circle.position
            if let lastGeneratedNode = platformsGenerator?.getLastGeneratedNode() {
                if !isAddingNewPlatforms && cam.frame.intersects(lastGeneratedNode.frame) {
                    isAddingNewPlatforms = true
                    let platforms = platformsGenerator?.generatePlatformsFrom()
                    platforms?.forEach({self.addChild($0)})
                    isAddingNewPlatforms = false
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        circle?.physicsBody?.applyImpulse(CGVector(dx: 1, dy: 0))
    }
    
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
}
