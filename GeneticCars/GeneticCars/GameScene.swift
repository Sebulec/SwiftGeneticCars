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
    
    let cam = SKCameraNode()
    private var isAddingNewPlatforms: Bool = false
    private var vehicles: [Vehicle] = []
    private var platformsGenerator: PlatformsGenerator?
    
    override func didMove(to view: SKView) {
        configureViews()
        configurePlatforms()
        addVehicles()
    }
    
    func addVehicles() {
        for i in 1...10 {
            var points: [CGPoint] = []
            for _ in 1...6 {
                points.append(CGPoint(x: Utilities.sharedInstance.randomNumber(inRange: -50...50), y: Utilities.sharedInstance.randomNumber(inRange: -50...50)))
            }
            let wheel = Wheel(positionInVehicle: CGPoint(x: 10, y: 10),radius: CGFloat(i))
            let wheel2 = Wheel(positionInVehicle: CGPoint(x: 20, y: 20),radius: CGFloat(i + 5))
            let vehicle = Vehicle(points: points, [wheel, wheel2])
            self.addChild(vehicle)
            self.vehicles.append(vehicle)
        }
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
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        self.physicsWorld.contactDelegate = self
        self.scene?.anchorPoint = CGPoint(x: 1, y: 1)
        self.view?.showsPhysics = true
        self.camera = cam
    }
    
    func configurePlatforms() {
        self.platformsGenerator = PlatformsGenerator(startingPoint: CGPoint(x: -((self.view?.bounds.width)!/2) , y: -(self.view?.bounds.height)!/2))
        platformsGenerator?.dificulty = 75
        platformsGenerator?.numberOfPlatforms = 200
        let platforms = platformsGenerator?.generatePlatformsFrom()
        platforms?.forEach({self.addChild($0)})
    }
    
    override func update(_ currentTime: TimeInterval) {
        sortVehicles()
        if let vehicle = getLeader() {
            cam.position = vehicle.position
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
    
    func getLeader() -> SKShapeNode? {
        return vehicles.first
    }
    
    func sortVehicles() {
        vehicles = vehicles.sorted(by: {distanceFromZeroPoint(vehicle: $0) > distanceFromZeroPoint(vehicle: $1)})
    }
    
    func distanceFromZeroPoint(vehicle: Vehicle) -> CGFloat {
        return vehicle.position.x
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        vehicles.forEach({$0.applyForce(1000)})
    }
    
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
}
