//
//  PlatformsGenerator.swift
//  GeneticCars
//
//  Created by Sebastian Kotarski on 08.11.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import SpriteKit
import GameKit

class PlatformsGenerator {
    private var platforms : [SKNode] = []
    private var platformWidth = CGFloat(200)
    private var platformHeight = CGFloat(20)
    var dificulty: Int = 50
    var startingPoint: CGPoint?
    var numberOfPlatforms: Int = 10
    
    convenience init(startingPoint: CGPoint) {
        self.init()
        self.startingPoint = startingPoint
    }
    
    func generatePlatformsFrom() -> [SKNode] {
        var lastInsertedPlatform : SKNode?
        if !platforms.isEmpty {
            lastInsertedPlatform = platforms.last!
        } else {
            lastInsertedPlatform = Platform.init(startingPoint: startingPoint!, width: platformWidth, height: platformHeight)
            platforms.append(lastInsertedPlatform!)
        }
        var newPlatforms : [SKNode] = []
        for _ in 1...10 {
            let lastStartingPoint = startingPoint
            startingPoint = CGPoint(x: (startingPoint?.x)! + platformWidth + CGFloat(-25), y: (startingPoint?.y)! + platformHeight + CGFloat(-25))
            let platform : Platform = Platform.init(startingPoint: startingPoint!, width: platformWidth, height: platformHeight)
            let block = platform.getPlatform(p1: lastStartingPoint!, p2: startingPoint!, size: CGSize(width: (lastStartingPoint?.distance(point: startingPoint!))!, height: platformHeight))
            block.physicsBody?.collisionBitMask = 1
            block.physicsBody?.categoryBitMask = 1
            newPlatforms.append(block)
        }
        for _ in 10...numberOfPlatforms {
            let lastStartingPoint = startingPoint
            startingPoint = CGPoint(x: (startingPoint?.x)! + platformWidth + CGFloat(Utilities.sharedInstance.randomNumber(inRange: -dificulty...dificulty)), y: (startingPoint?.y)! + platformHeight + CGFloat(Utilities.sharedInstance.randomNumber(inRange: -dificulty...dificulty)))
            let platform : Platform = Platform.init(startingPoint: startingPoint!, width: platformWidth, height: platformHeight)
            let block = platform.getPlatform(p1: lastStartingPoint!, p2: startingPoint!, size: CGSize(width: (lastStartingPoint?.distance(point: startingPoint!))!, height: platformHeight))
            block.physicsBody?.collisionBitMask = 1
            block.physicsBody?.categoryBitMask = 1
            newPlatforms.append(block)
        }
        platforms.append(contentsOf: newPlatforms)
        return newPlatforms
    }
    
    func getLastGeneratedNode() -> SKNode? {
        return platforms.last
    }
    
    func getPositionOfLowestPlatform() -> CGPoint {
        return (platforms.max(by: {$0.position.y > $1.position.y})?.position)!
    }
    
}
