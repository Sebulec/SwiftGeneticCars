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
    
    static let mutationRate = 20
    static let scaleFactor = 1.0
    
    static func getMutatedSolution(base: Solution, solutions: [Solution]) -> Solution {
        let mutatedSolution = Solution()
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
                mutatedSolution.positionCoordinatesGenes[index] = basePositionGene
                
                print("Mutation value for position: \(basePositionGene)")
            } else {
                mutatedSolution.positionCoordinatesGenes[index] = base.positionCoordinatesGenes[index]
            }
        }
        for index in 0...GameRules.numberOfWheelsInSolution - 1 {
            if shouldMutate() {
                var baseWheelPositionGene = base.wheelIndexesGenes[index]
                let firstPositionGene = firstRandomSelectedSolution.wheelIndexesGenes[index]
                let secondPositionGene = secondRandomSelectedSolution.wheelIndexesGenes[index]
                let mutationValue = Double(scaleFactor * Double(firstPositionGene - secondPositionGene))
                baseWheelPositionGene = Int(Double(baseWheelPositionGene) + mutationValue)
                mutatedSolution.wheelIndexesGenes[index] = baseWheelPositionGene
                
                print("Mutation value for wheel position: \(baseWheelPositionGene)")
            } else {
                mutatedSolution.wheelIndexesGenes[index] = base.wheelIndexesGenes[index]
            }
        }
        for index in 0...GameRules.numberOfWheelsInSolution - 1 {
            if shouldMutate() {
                var baseWheelSizeGene = base.wheelRadiusGenes[index]
                let firstPositionGene = firstRandomSelectedSolution.wheelRadiusGenes[index]
                let secondPositionGene = secondRandomSelectedSolution.wheelRadiusGenes[index]
                let mutationValue = CGFloat(scaleFactor * Double(firstPositionGene - secondPositionGene))
                baseWheelSizeGene = baseWheelSizeGene + mutationValue
                mutatedSolution.wheelRadiusGenes[index] = baseWheelSizeGene
                
                print("Mutation value for wheel size: \(baseWheelSizeGene)")

            } else {
                mutatedSolution.wheelRadiusGenes[index] = base.wheelRadiusGenes[index]
            }
        }
        mutatedSolution.fixGenesIfBroken()
        return mutatedSolution
    }
    
    static func shouldMutate() -> Bool {
        let res = Utilities.sharedInstance.randomNumber(inRange: 0...100) < mutationRate
        return res
    }
}
