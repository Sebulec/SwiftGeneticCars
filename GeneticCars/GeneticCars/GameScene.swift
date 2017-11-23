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
    
    weak var gameDelegate: GameDelegate?
    
    private let cam = SKCameraNode()
    private var isAddingNewPlatforms: Bool = false
    private var movementTolerance = CGFloat(10)
    private var vehiclesWithScores: [Vehicle : CGFloat] = [:]
    private var vehiclesWithPreviousScores: [Vehicle : CGFloat] = [:]
    private var vehiclesWithTime: [Vehicle : CGFloat] = [:]
    private var vehiclesWithPreviousTime: [Vehicle : CGFloat] = [:]
    private var vehicles: [Vehicle] = []
    private var platformsGenerator: PlatformsGenerator?
    private var timer = Timer()
    
    override func didMove(to view: SKView) {
        configureViews()
        configurePlatforms()
        scheduledTimerWithTimeInterval()
    }
    
    func cleanData() {
        self.vehicles.removeAll()
        self.vehiclesWithPreviousTime.removeAll()
        self.vehiclesWithTime.removeAll()
        self.vehiclesWithPreviousScores.removeAll()
        self.vehiclesWithScores.removeAll()
    }
    
    private func configureViews() {
        self.scene?.size = (view?.bounds.size)!
        self.view?.backgroundColor = UIColor.white
        self.backgroundColor = UIColor.white
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        self.physicsWorld.contactDelegate = self
        self.scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.showsPhysics = true
        self.camera = cam
    }
    
    private func configurePlatforms() {
        self.platformsGenerator = PlatformsGenerator(startingPoint: CGPoint(x: -((self.view?.bounds.width)!/2) , y: -(self.view?.bounds.height)!/2))
        platformsGenerator?.dificulty = 75
        platformsGenerator?.numberOfPlatforms = 200
        let platforms = platformsGenerator?.generatePlatformsFrom()
        platforms?.forEach({self.addChild($0)})
    }
    
    override func update(_ currentTime: TimeInterval) {
        sortVehicles()
        removeDeadVehicles()
        vehicles.forEach({$0.applyForce(-1000)})
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
        updateGameStats()
    }
    private func sortVehicles() {
        vehicles = vehicles.sorted(by: {distanceFromZeroPoint(vehicle: $0) > distanceFromZeroPoint(vehicle: $1)})
    }
    
    private func distanceFromZeroPoint(vehicle: Vehicle) -> CGFloat {
        return vehicle.position.x
    }
    
    private func updateGameStats() {
        updateVehiclesScores()
        gameDelegate?.updateGame(with: vehiclesWithScores)
    }
    
    private func getLeader() -> SKShapeNode? {
        return vehicles.first
    }
    
    private func removeDeadVehicles() {
        self.removeChildren(in: vehicles.filter({shouldRemoveVehicle(node: $0)}))
    }
    
    private func shouldRemoveVehicle(node: SKNode) -> Bool {
        if node.physicsBody == nil {
            return true
        }
        let point = platformsGenerator?.getPositionOfLowestPlatform()
        if (point?.y)! > node.position.y {
            return true
        }
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nextPopulation()
        self.camera?.position = (self.getLeader()?.position)!
    }
    
    private func nextPopulation() {
        reloadScene()
    }
    
    private func updateVehiclesScores() {
        self.vehiclesWithScores = vehicles.reduce([:]) { (acc, vehicle) -> [Vehicle : CGFloat] in
            var dict = acc
            dict[vehicle] = distanceFromZeroPoint(vehicle: vehicle)
            return dict
        }
    }
    
    private func reloadScene() {
        self.timer.invalidate()
        self.removeAllChildren()
        configureViews()
        configurePlatforms()
        cleanData()
        scheduledTimerWithTimeInterval()
    }
    
    func scheduledTimerWithTimeInterval(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc private func updateCounting(){
        updateVehiclesTimes()
        startNextPopulationIfVehiclesStopped()
        self.vehiclesWithPreviousScores = self.vehiclesWithScores
        self.vehiclesWithPreviousTime = self.vehiclesWithTime
    }
    
    private func updateVehiclesTimes() {
        if !vehiclesWithPreviousTime.isEmpty {
            self.vehiclesWithTime = vehicles.reduce([:]) { (acc, vehicle) -> [Vehicle : CGFloat] in
                let previousScore = vehiclesWithPreviousScores[vehicle] ?? 0
                let lastScore = vehiclesWithScores[vehicle]!
                var dict = acc
                dict[vehicle] = lastScore - previousScore > movementTolerance ? (vehiclesWithPreviousTime[vehicle]! + 1) : vehiclesWithPreviousTime[vehicle]!
                //                print("vehicle: \(vehicles.index(of: vehicle)!) has time: \(dict[vehicle]!)")
                return dict
            }
        } else {
            vehiclesWithTime = vehicles.reduce([:]) { (acc, vehicle) -> [Vehicle : CGFloat] in
                var dict = acc
                dict[vehicle] = CGFloat(0)
                return dict
            }
        }
    }
    
    private func startNextPopulationIfVehiclesStopped() {
        if vehicles.filter({vehiclesWithTime[$0] != vehiclesWithPreviousTime[$0]}).isEmpty {
            nextPopulation()
        }
    }
}
