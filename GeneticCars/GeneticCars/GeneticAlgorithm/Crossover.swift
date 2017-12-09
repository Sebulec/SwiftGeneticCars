//
//  Crossover.swift
//  GeneticCars
//
//  Created by Sebastian Kotarski on 18.11.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import Foundation

struct Crossover {
    static let crossOverRate = 40
    
    static func crossOver(firstSolution: Solution, secondSolution: Solution) -> Solution {
        let newSolution = Solution()
        for index in 0...GameRules.numberOfPointsInSolution*2 - 1 {
            if shouldCrossover() {
                newSolution.positionCoordinatesGenes[index] = firstSolution.positionCoordinatesGenes[index]
            } else {
                newSolution.positionCoordinatesGenes[index] = secondSolution.positionCoordinatesGenes[index]
            }
        }
        for index in 0...GameRules.numberOfWheelsInSolution - 1 {
            if shouldCrossover() {
                newSolution.wheelIndexesGenes[index] = firstSolution.wheelIndexesGenes[index]
            } else {
                newSolution.wheelIndexesGenes[index] = secondSolution.wheelIndexesGenes[index]
            }
        }
        for index in 0...GameRules.numberOfWheelsInSolution - 1 {
            if shouldCrossover() {
                newSolution.wheelRadiusGenes[index] = firstSolution.wheelRadiusGenes[index]
            } else {
                newSolution.wheelRadiusGenes[index] = secondSolution.wheelRadiusGenes[index]
            }
        }
        return newSolution
    }
    
    static func shouldCrossover() -> Bool {
        return Utilities.sharedInstance.randomNumber(inRange: 0...100) < crossOverRate
    }
    
}
