//
//  Solution.swift
//  GeneticCars
//
//  Created by Sebastian Kotarski on 11.11.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import CoreGraphics

struct Solution {
    var positionCoordinatesGenes: [CGFloat] = []
    var wheelIndexesGenes: [Int] = []
    var wheelRadiusGenes: [CGFloat] = []
    
    init() {
        for _ in 0...GameRules.numberOfPointsInSolution*2 - 1 {
            positionCoordinatesGenes.append(CGFloat(0))
        }
        for _ in 0...GameRules.numberOfWheelsInSolution - 1 {
            wheelIndexesGenes.append(0)
        }
        for _ in 0...GameRules.numberOfWheelsInSolution - 1 {
            wheelRadiusGenes.append(CGFloat(0))
        }
    }
}
