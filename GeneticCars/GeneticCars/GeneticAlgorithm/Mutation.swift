//
//  Mutation.swift
//  GeneticCars
//
//  Created by Sebastian Kotarski on 18.11.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import Foundation
import CoreGraphics

struct Mutation {
    
    static let mutationRate = 5
    static let scaleFactor = 0.3
    
    static func getMutatedSolution(base: Solution, solutions: [Solution]) -> Solution {
        var solutionsWithoutRepeates = solutions
        let firstRandomIndex = Utilities.sharedInstance.randomNumber(inRange: 0...solutionsWithoutRepeates.count - 1)
        let firstRandomSelectedSolution = solutionsWithoutRepeates[firstRandomIndex]
        solutionsWithoutRepeates.remove(at: firstRandomIndex)
        let secondRandomIndex = Utilities.sharedInstance.randomNumber(inRange: 0...solutionsWithoutRepeates.count - 1)
        let secondRandomSelectedSolution = solutionsWithoutRepeates[secondRandomIndex]
        for index in 0...GameRules.numberOfPointsInSolution*2 - 1 {
            if shouldMutate() {
                var basePositionGene = base.positionCoordinatesGenes[index]
                let firstPositionGene = firstRandomSelectedSolution.positionCoordinatesGenes[index]
                let secondPositionGene = secondRandomSelectedSolution.positionCoordinatesGenes[index]
                let mutationValue = CGFloat((scaleFactor * (Double(firstPositionGene - secondPositionGene))))
                basePositionGene = basePositionGene + mutationValue
                base.positionCoordinatesGenes[index] = basePositionGene
            }
        }
        for index in 0...GameRules.numberOfWheelsInSolution - 1 {
            if shouldMutate() {
                var baseWheelPositionGene = base.wheelIndexesGenes[index]
                let firstPositionGene = firstRandomSelectedSolution.wheelIndexesGenes[index]
                let secondPositionGene = secondRandomSelectedSolution.wheelIndexesGenes[index]
                let mutationValue = Double(scaleFactor * Double(firstPositionGene - secondPositionGene))
                baseWheelPositionGene = Int(Double(baseWheelPositionGene) + mutationValue)
                base.wheelIndexesGenes[index] = baseWheelPositionGene
            }
        }
        for index in 0...GameRules.numberOfWheelsInSolution - 1 {
            if shouldMutate() {
                var baseWheelSizeGene = base.wheelRadiusGenes[index]
                let firstPositionGene = firstRandomSelectedSolution.wheelRadiusGenes[index]
                let secondPositionGene = secondRandomSelectedSolution.wheelRadiusGenes[index]
                let mutationValue = CGFloat(scaleFactor * Double(firstPositionGene - secondPositionGene))
                baseWheelSizeGene = baseWheelSizeGene + mutationValue
                base.wheelRadiusGenes[index] = baseWheelSizeGene
            }
        }
        base.fixGenesIfBroken()
        return base
    }
    
    static func shouldMutate() -> Bool {
        let res = Utilities.sharedInstance.randomNumber(inRange: 0...100) < mutationRate
        print(res)
        return res
    }
}
