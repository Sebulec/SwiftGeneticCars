//
//  GeneticAlgorithm.swift
//  GeneticCars
//
//  Created by Sebastian Kotarski on 18.11.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import Foundation
import CoreGraphics

class GeneticAlgorithm {
    let populationSize = 10
    var numberOfIteration = 0
    var bestSolutionOfAllTime : Solution?
    
    func getNextPopulation(previous: [Solution]) -> [Solution] {
        numberOfIteration += 1
        //create population
        let newPopulation : [Solution] = []
        // selection
        // todo
        
        // mutation
        // todo
        
        // crossover
        // todo
        
        let bestSolutionForPopulation = previous.filter({$0.score! > bestSolutionOfAllTime?.score ?? SolutionScore()}).max(by: {$0.score! > $1.score!})
        if bestSolutionForPopulation != nil {
            bestSolutionOfAllTime = bestSolutionForPopulation
        }
        
        return initializePopulation()
    }
    
    func initializePopulation() -> [Solution] {
        var population : [Solution] = []
        for _ in 1...populationSize {
            population.append(getRandomSolution())
        }
        return population
    }
    
    private func getRandomSolution() -> Solution {
        var positionCoordinatesGenes: [CGFloat] = []
        var wheelIndexesGenes: [Int] = []
        var wheelRadiusGenes: [CGFloat] = []
        
        for _ in 0...GameRules.numberOfPointsInSolution - 1 {
            positionCoordinatesGenes.append(CGFloat(Utilities.sharedInstance.randomNumber(inRange: -GameRules.coordinatesRangeForHorizontal...GameRules.coordinatesRangeForHorizontal)))
            positionCoordinatesGenes.append(CGFloat(Utilities.sharedInstance.randomNumber(inRange: -GameRules.coordinatesRangeForVertical...GameRules.coordinatesRangeForVertical)))
        }
        for _ in 0...GameRules.numberOfWheelsInSolution - 1 {
            wheelIndexesGenes.append(Utilities.sharedInstance.randomNumber(inRange: 0...GameRules.numberOfPointsInSolution - 1))
        }
        for _ in 0...GameRules.numberOfWheelsInSolution - 1 {
            wheelRadiusGenes.append(CGFloat(Utilities.sharedInstance.randomNumber(inRange: 1...GameRules.wheelSizeRange)))
        }
        let solution = Solution(positionCoordinatesGenes: positionCoordinatesGenes, wheelIndexesGenes: wheelIndexesGenes, wheelRadiusGenes: wheelRadiusGenes)
        return solution
    }
    
    private func shouldStop() -> Bool {
        // todo MAX_ITER/minimum quality?
        return false
    }
    
}
