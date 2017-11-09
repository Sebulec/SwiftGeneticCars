//
//  Vehicle.swift
//  GeneticCars
//
//  Created by Sebastian Kotarski on 08.11.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import SpriteKit
import GameKit

class Vehicle: SKShapeNode {
    
    var view: SKView?
    
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
