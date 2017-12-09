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
    
    let selectionType = SelectionType.rouletteWheel
    
    func getNextPopulation(previous: [Solution]) -> [Solution] {
        numberOfIteration += 1
        //create population
        var newPopulation : [Solution] = []
        for _ in 0...populationSize {
            // selection
            let selectedSolution = Selection.selectSolutionsWithSelectionType(solutions: previous, selectionType: selectionType, ["groupSize" : 10])
            // mutation
            let mutatedSolution = Mutation.getMutatedSolution(base: selectedSolution, solutions: previous)
            // crossover
            let crossOverSolution = Crossover.crossOver(firstSolution: selectedSolution, secondSolution: mutatedSolution)
            newPopulation.append(crossOverSolution)
        }
        
        let bestSolutionForPopulation = previous.filter({$0.score! > (bestSolutionOfAllTime?.score ?? SolutionScore())}).sorted(by: {$0.score! > $1.score!}).first
        if bestSolutionForPopulation != nil {
            bestSolutionOfAllTime = bestSolutionForPopulation
        }
        print("Best distance \(String(describing: bestSolutionForPopulation?.score?.distance))")
        return newPopulation
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
            wheelRadiusGenes.append(CGFloat(Utilities.sharedInstance.randomNumber(inRange: 1...Int(GameRules.wheelSizeRange))))
        }
        let solution = Solution(positionCoordinatesGenes: positionCoordinatesGenes, wheelIndexesGenes: wheelIndexesGenes, wheelRadiusGenes: wheelRadiusGenes)
        return solution
    }
    
    private func shouldStop() -> Bool {
        // todo MAX_ITER/minimum quality?
        return false
    }
    
}
