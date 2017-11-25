//
//  Solution.swift
//  GeneticCars
//
//  Created by Sebastian Kotarski on 11.11.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import CoreGraphics

class Solution {
    var positionCoordinatesGenes: [CGFloat] = []
    var wheelIndexesGenes: [Int] = []
    var wheelRadiusGenes: [CGFloat] = []
    
    var score: SolutionScore?
    
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
    
    init(positionCoordinatesGenes: [CGFloat], wheelIndexesGenes: [Int], wheelRadiusGenes: [CGFloat]) {
        self.positionCoordinatesGenes = positionCoordinatesGenes
        self.wheelIndexesGenes = wheelIndexesGenes
        self.wheelRadiusGenes = wheelRadiusGenes
    }
}
