//
//  VehicleFenotype.swift
//  GeneticCars
//
//  Created by Sebastian Kotarski on 18.11.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import Foundation
import CoreGraphics
// two-way data converter from chromosome to fenotype and contrariwise
struct VehicleFenotype {
    static func getChromoseFromFenotype(vehicle: Vehicle) -> Solution {
        return vehicle.solution!
    }
    static func getFenotypeFromChromosome(solution: Solution) -> Vehicle {
        var points: [CGPoint] = []
        var wheels: [Wheel] = []
        for i in 0...GameRules.numberOfPointsInSolution - 1 {
            let x = solution.positionCoordinatesGenes[i*2]
            let y = solution.positionCoordinatesGenes[i*2 + 1]
            points.append(CGPoint(x: x, y: y))
        }
        for i in 0...GameRules.numberOfWheelsInSolution - 1 {
            let wheel = Wheel(pinnedIndexPoint: solution.wheelIndexesGenes[i], radius: solution.wheelRadiusGenes[i])
            wheels.append(wheel)
        }
        let vehicle = Vehicle(points: points, wheels)
        vehicle.solution = solution
        return vehicle
    }
}
