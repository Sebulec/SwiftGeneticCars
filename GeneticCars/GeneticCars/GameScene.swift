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
    
    override func didMove(to view: SKView) {
        configureViews()
        //
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
        self.addChild(circle!)
        
        let line = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 2, height: 10))
        line.fillColor = UIColor.white
        line.lineWidth = 1
        circle?.addChild(line)
        
        circle?.physicsBody?.affectedByGravity = true
        
        let action = SKAction.repeatForever(SKAction.rotate(byAngle: .pi/4, duration: 1/20))
        
        //        circle?.run(action)
        
        let path = self.generatePath()
//        let yourLine: SKShapeNode = SKShapeNode.init(path: path)
        let yourLine: SKShapeNode = SKShapeNode.init()
        yourLine.path = path
        yourLine.physicsBody = SKPhysicsBody(edgeLoopFrom: path)
        yourLine.physicsBody?.affectedByGravity = false
        yourLine.lineWidth = 4
        yourLine.fillColor = SKColor.red
        yourLine.physicsBody?.isDynamic = false
        self.addChild(yourLine)
        //        let bar = getPlatform()
        //        self.addChild(bar)
        //        let bar2 = getAnotherPlatformToExisting(existingPlatform: bar)
        //        self.addChild(bar2)
        //
        //
        //
        //        let anchor = SKNode()
        //
        //        anchor.position = CGPoint(x: 0, y: 0)
        //        anchor.zRotation = .pi / 4
        //        anchor.physicsBody = SKPhysicsBody()
        //        anchor.physicsBody?.isDynamic = false
        //        let pinJoint = SKPhysicsJointPin.joint(withBodyA: bar.physicsBody!,
        //                                               bodyB: bar2.physicsBody!,
        //                                               anchor: CGPoint(x: bar.position.x + bar.size.width, y: 0))
        //        self.physicsWorld.add(pinJoint)
    }
    
    func getPlatform() -> SKSpriteNode {
        let rectangle = SKSpriteNode.init(imageNamed: "grass")
        rectangle.size = CGSize(width: 300, height: 10)
        rectangle.zPosition = 1
        rectangle.position.x = 0
        rectangle.physicsBody = SKPhysicsBody(rectangleOf: rectangle.size)
        rectangle.name = "bar"
        rectangle.physicsBody?.friction = 0.5
        rectangle.physicsBody?.isDynamic = false
        rectangle.physicsBody?.affectedByGravity = false
        return rectangle
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
    
    func randomNumberBetween(_ from: Int, to: Int) -> Int {
        return from.unsafeAdding(Int(arc4random_uniform(26))) % (to - from + 1);
    }
    
    func generatePath() -> CGMutablePath {
        let path : CGMutablePath = CGMutablePath()
        let p0 = CGPoint(x: -(self.view?.bounds.height)!, y: -200)
        path.move(to: p0)
        //        let p1 = CGPoint(x: CGFloat(-Int((self.view?.bounds.height)!) + 150 + randomNumberBetween(150, to: 300)), y: CGFloat(-randomNumberBetween(150, to: 300)))
        //        let p2 = CGPoint(x: CGFloat(-Int((self.view?.bounds.height)!) + 250 + randomNumberBetween(150, to: 300)), y: CGFloat(-randomNumberBetween(150, to: 300)))
        //        let p3 = CGPoint(x: CGFloat((self.view?.bounds.height)!), y: CGFloat(-randomNumberBetween(150, to: 300)))
        //
        var i = 1
        let width = Int(-(self.view?.bounds.height)!)
        while i <= 10 {
            //            let p1 = CGPoint(x: CGFloat(-Int((self.view?.bounds.height)!)/2 + randomNumberBetween(i * 10, to: i * 30)), y: -200 + CGFloat(-randomNumberBetween(i * 10, to: i * 30)))
            //            let p2 = CGPoint(x: CGFloat(-Int((self.view?.bounds.height)!)/2 + randomNumberBetween(i * 10, to: i * 30)), y: -200 + CGFloat(-randomNumberBetween(i * 10, to: i * 30)))
            //            let p3 = CGPoint(x: CGFloat((self.view?.bounds.height)!)/2, y: -200 + CGFloat(-randomNumberBetween(i * 10, to: i * 30)))
            
            
            let p1 = CGPoint(x: i * 100, y: width + (i - width) / 2)
            let p2 = CGPoint(x: i * 200, y: width + (i - width) / 2)
            let p3 = CGPoint(x: i * 300, y: i * -100 + 200)
            
            let v: CGFloat = 0.8
            
            let cp1x: CGFloat = p1.x + v * (p1.x - p0.x)
            let cp1y: CGFloat = p1.y + v * (p1.y - p0.y)
            let cp2x: CGFloat = p2.x + v * (p2.x - p2.x)
            let cp2y: CGFloat = p2.y + v * (p2.y - p2.y)
            
            path.addCurve(to: CGPoint(x: cp1x, y: cp1y), control1: CGPoint(x: cp2x, y: cp2y), control2: CGPoint(x: p3.x, y: p3.y))
            
            i = i + 1
            
        }
        
        //        let p1 = CGPoint(x: -(self.view?.bounds.height)! / 2, y: CGFloat( -200.0))
        //        let p2 = CGPoint(x: -(self.view?.bounds.height)! / 3, y: CGFloat(-200))
        
        //        let p3 = CGPoint(x: (self.view?.bounds.height)!, y: CGFloat((-200 + 20.0)))
        //        let v: CGFloat = 0.3
        //
        //        let cp1x: CGFloat = p1.x + v * (p1.x - p0.x)
        //        let cp1y: CGFloat = p1.y + v * (p1.y - p0.y)
        //        let cp2x: CGFloat = p2.x + v * (p2.x - p2.x)
        //        let cp2y: CGFloat = p2.y + v * (p2.y - p2.y)
        //
        //        path.addCurve(to: CGPoint(x: cp1x, y: cp1y), control1: CGPoint(x: cp2x, y: cp2y), control2: CGPoint(x: p3.x, y: p3.y))
        //
        return path
    }
    
    func configureViews() {
        self.scene?.size = (view?.bounds.size)!
        self.view?.backgroundColor = UIColor.white
        self.backgroundColor = UIColor.white
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -1)
        self.physicsWorld.contactDelegate = self
        self.scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.showsPhysics = true
        self.camera = cam
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if let circle = self.circle {
            cam.position = circle.position
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        circle?.physicsBody?.applyTorque(10.0)
        //        circle?.physicsBody?.applyImpulse(10.0)
                circle?.physicsBody?.applyImpulse(CGVector(dx: 1, dy: 0))
//                circle?.physicsBody?.applyForce(CGVector(dx: 100, dy: 0))
        //
        //        self.removeAllChildren()
        //
        //        let path = self.generatePath()
        //        let yourLine: SKShapeNode = SKShapeNode.init(path: path)
        //        yourLine.physicsBody = SKPhysicsBody(polygonFrom: path)
        //        yourLine.physicsBody?.affectedByGravity = false
        //        yourLine.physicsBody?.isDynamic = false
        //        self.addChild(yourLine)
        
//                circle?.physicsBody?.applyAngularImpulse(100.0)
    }

    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        
        
        //        let secondNode = contact.bodyB.node as! SKShapeNode
        //        print(contact.contactPoint)
        //        if (contact.bodyB.categoryBitMask == arrowCategory) &&
        //            (contact.bodyA.categoryBitMask == ballCategory) {
        //
        //            let contactPoint = contact.contactPoint
        //            let contact_y = contactPoint.y
        //            let target_y = secondNode.position.y
        //            let margin = secondNode.frame.size.height/2 - 25
        //
        //            if (contact_y > (target_y - margin)) &&
        //                (contact_y < (target_y + margin)) {
        //                print("Hit")
        //            }
        //        }
    }
    
    func getVehicle2() {
        let rectangle = SKSpriteNode.init(color: UIColor.white, size: CGSize(width: 120, height: 8))
        rectangle.physicsBody = SKPhysicsBody(edgeLoopFrom: rectangle.frame)
        rectangle.position = CGPoint(x: 100,
                                     y: 100)
        rectangle.zRotation = CGFloat.pi / 2
        rectangle.physicsBody?.pinned = true
        
        scene?.addChild(rectangle)
        
        let anchor = SKNode()
        
        anchor.position = CGPoint(x: 100,
                                  y: 100)
        anchor.zRotation = CGFloat.pi / 2
        anchor.physicsBody = SKPhysicsBody()
        anchor.physicsBody?.isDynamic = false
        
        let jointed = SKSpriteNode(imageNamed: "grass")
        jointed.physicsBody = SKPhysicsBody(edgeLoopFrom: jointed.frame)
        
        scene?.addChild(anchor)
        anchor.addChild(jointed)
        
        let pinJoint = SKPhysicsJointPin.joint(withBodyA: anchor.physicsBody!,
                                               bodyB: jointed.physicsBody!,
                                               anchor: anchor.position)
    }
    
    func getVehicle() -> SKNode {
        var vehicle = SKNode()
        
        var joints = [SKPhysicsJoint]()
        let wheelOffsetY:CGFloat    =   60;
        let damping:CGFloat     =   1;
        let frequency :CGFloat    =   4;
        
        let chassis = SKSpriteNode.init(color: UIColor.white, size: CGSize(width: 120, height: 8))
        chassis.position = CGPoint(x: (self.view?.bounds.width)!/2, y: (self.view?.bounds.height)!/2)
        chassis.physicsBody =  SKPhysicsBody.init(rectangleOf: chassis.size)
        vehicle.addChild(chassis)
        
        
        let ctop = SKSpriteNode.init(color: UIColor.green, size: CGSize(width: 70, height: 16))
        
        ctop.position = CGPoint(x: chassis.position.x+20, y: chassis.position.y+12)
        ctop.physicsBody = SKPhysicsBody.init(rectangleOf: ctop.size)
        vehicle.addChild(ctop)
        
        
        
        let cJoint = SKPhysicsJointFixed.joint(withBodyA: chassis.physicsBody!, bodyB: ctop.physicsBody!, anchor: CGPoint(x: ctop.position.x, y: ctop.position.y))
        
        
        
        let leftWheel = SKSpriteNode(imageNamed: "grass")
        leftWheel.position = CGPoint(x: chassis.position.x - chassis.size.width / 2, y: chassis.position.y - wheelOffsetY)  //Always set position before physicsBody
        leftWheel.physicsBody = SKPhysicsBody(circleOfRadius: leftWheel.size.width/2)
        leftWheel.physicsBody!.allowsRotation = true;
        vehicle.addChild(leftWheel)
        
        
        let rightWheel = SKSpriteNode(imageNamed: "grass")
        rightWheel.position = CGPoint(x: chassis.position.x + chassis.size.width / 2, y: chassis.position.y - wheelOffsetY)  //Always set position before physicsBody
        rightWheel.physicsBody = SKPhysicsBody(circleOfRadius: leftWheel.size.width/2)
        rightWheel.physicsBody!.allowsRotation = true;
        vehicle.addChild(rightWheel)
        
        
        //--------------------- LEFT SUSPENSION ---------------------- //
        
        let leftShockPost = SKSpriteNode(color: UIColor.blue, size:CGSize(width:7, height: wheelOffsetY))
        
        leftShockPost.position = CGPoint(x:chassis.position.x - chassis.size.width / 2, y: chassis.position.y - leftShockPost.size.height/2)
        
        leftShockPost.physicsBody = SKPhysicsBody(rectangleOf: leftShockPost.size)
        vehicle.addChild(leftShockPost)
        
        let leftSlide = SKPhysicsJointSliding.joint(withBodyA: chassis.physicsBody!, bodyB: leftShockPost.physicsBody!, anchor:CGPoint(x:leftShockPost.position.x, y: leftShockPost.position.y), axis:CGVector(dx: 0.0, dy: 1.0))
        
        
        leftSlide.shouldEnableLimits = true;
        leftSlide.lowerDistanceLimit = 5;
        leftSlide.upperDistanceLimit = wheelOffsetY;
        
        
        let leftSpring = SKPhysicsJointSpring.joint(withBodyA: chassis.physicsBody!, bodyB: leftWheel.physicsBody!, anchorA: CGPoint(x:chassis.position.x - chassis.size.width / 2, y: chassis.position.y), anchorB: leftWheel.position)
        
        
        leftSpring.damping = damping;
        leftSpring.frequency = frequency;
        
        let lPin = SKPhysicsJointPin.joint(withBodyA: leftShockPost.physicsBody!, bodyB:leftWheel.physicsBody!, anchor:leftWheel.position)
        
        
        //--------------------- Right SUSPENSION ---------------------- //
        
        let rightShockPost = SKSpriteNode(color: UIColor.blue, size:CGSize(width: 7, height: wheelOffsetY) )
        
        rightShockPost.position = CGPoint(x:chassis.position.x + chassis.size.width / 2, y: chassis.position.y - rightShockPost.size.height/2)
        
        rightShockPost.physicsBody = SKPhysicsBody(rectangleOf: rightShockPost.size)
        vehicle.addChild(rightShockPost)
        
        let rightSlide = SKPhysicsJointSliding.joint(withBodyA: chassis.physicsBody!, bodyB: rightShockPost.physicsBody!, anchor:CGPoint(x:rightShockPost.position.x, y: rightShockPost.position.y), axis:CGVector(dx: 0.0, dy: 1.0))
        
        
        rightSlide.shouldEnableLimits = true;
        rightSlide.lowerDistanceLimit = 5;
        rightSlide.upperDistanceLimit = wheelOffsetY;
        
        
        let rightSpring = SKPhysicsJointSpring.joint(withBodyA: chassis.physicsBody!, bodyB: rightWheel.physicsBody!, anchorA: CGPoint(x: chassis.position.x - chassis.size.width / 2, y: chassis.position.y), anchorB: rightWheel.position)
        
        
        rightSpring.damping = damping;
        rightSpring.frequency = frequency;
        
        let rPin = SKPhysicsJointPin.joint(withBodyA: leftShockPost.physicsBody!, bodyB:rightWheel.physicsBody!, anchor:rightWheel.position)
        
        
        // Add all joints to the array.
        
        joints.append(cJoint)
        joints.append(leftSlide)
        joints.append(leftSpring)
        joints.append(rightSlide)
        joints.append(rightSpring)
        joints.append(rPin)
        
        return vehicle
    }
    
}
