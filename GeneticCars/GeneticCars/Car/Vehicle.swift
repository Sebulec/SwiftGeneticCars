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
    
    static let numberOfPoints = 5
    var firstWheel: Wheel?
    var secondWheel: Wheel?
    convenience init(points: [CGPoint], _ wheels: [Wheel]) {
        let path = CGMutablePath()
        path.move(to: points.first!)
        for point in points {
            path.addLine(to: point)
        }
        path.addLine(to: points.first!)
        self.init(path: path)
        let randomColor = Utilities.sharedInstance.getRandomColor()
        self.physicsBody = SKPhysicsBody(polygonFrom: self.path!)
        self.position = CGPoint(x: 100, y: 100)
        self.fillColor = randomColor
        self.lineWidth = 1.5
        self.strokeColor = randomColor
        self.physicsBody?.mass = 2
        let wheel = wheels.first
        wheel?.position = points[2]
        wheel?.physicsBody?.pinned = true
        self.firstWheel = wheel
        
        
        let wheel2 = wheels.last
        wheel2?.position = points[3]
        wheel2?.physicsBody?.pinned = true
        self.secondWheel = wheel2
        
        self.addChild(wheel2!)
        self.addChild(wheel!)
        
        self.physicsBody?.categoryBitMask = 0;
        self.firstWheel?.physicsBody?.categoryBitMask = 0;
        self.secondWheel?.physicsBody?.categoryBitMask = 0;
        
        self.firstWheel?.physicsBody?.contactTestBitMask = 1;
        self.secondWheel?.physicsBody?.contactTestBitMask = 1;
        self.physicsBody?.contactTestBitMask = 1;
        
    }
    
    func applyForce(_ force: CGFloat) {
        firstWheel?.physicsBody?.angularVelocity = -force
        secondWheel?.physicsBody?.angularVelocity = -force
    }
    
}
