//
//  Wheel.swift
//  GeneticCars
//
//  Created by Sebastian Kotarski on 11.11.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import SpriteKit
import GameKit

class Wheel: SKShapeNode {
    
    var positionInVehicle: CGPoint = CGPoint(x: 0, y: 0)
    var pinnedIndexPoint: Int = 0
    
    convenience init(pinnedIndexPoint: Int, radius: CGFloat) {
        self.init(circleOfRadius: radius)
        self.fillColor = UIColor.red
        self.zPosition = 1
        self.lineWidth = 0
        self.lineCap = CGLineCap(rawValue: 1)!
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.density = 1
        self.physicsBody?.mass = 0.25
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.allowsRotation = true
        let line = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 2, height: radius))
        line.fillColor = UIColor.white
        line.lineWidth = 1
        self.addChild(line)
        self.physicsBody?.affectedByGravity = true
        self.pinnedIndexPoint = pinnedIndexPoint
    }
}
