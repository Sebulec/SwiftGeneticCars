//
//  Platform.swift
//  GeneticCars
//
//  Created by Sebastian Kotarski on 08.11.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import SpriteKit
import GameKit

class Platform: SKShapeNode {
    
    convenience init(startingPoint: CGPoint, width: CGFloat, height: CGFloat) {
        self.init(circleOfRadius: 2)
        self.position = startingPoint
        self.fillColor = UIColor.blue
        self.zPosition = 1
        self.lineWidth = 0
        self.lineCap = CGLineCap(rawValue: 1)!
        self.physicsBody = SKPhysicsBody(circleOfRadius: 2)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.restitution = 1
        self.physicsBody?.mass = 1000
        self.physicsBody?.density = 1
        self.physicsBody?.friction = 0.5
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.affectedByGravity = false
    }
    
    func getPlatform(p1: CGPoint, p2: CGPoint, size: CGSize) -> SKNode {
        let block = SKSpriteNode(color: UIColor.lightGray , size: size)
        block.physicsBody = SKPhysicsBody(rectangleOf: block.frame.size)
        block.position = CGPoint(midPointBetweenA: p1, andB: p2)
        block.physicsBody!.affectedByGravity = false
        block.physicsBody!.isDynamic = false
        block.zRotation = atan2(p2.y-p1.y, p2.x-p1.x)
        return block
    }
}
