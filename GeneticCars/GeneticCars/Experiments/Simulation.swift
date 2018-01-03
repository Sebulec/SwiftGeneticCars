//
//  Simulation.swift
//  GeneticCars
//
//  Created by Sebastian Kotarski on 09.12.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import UIKit

struct Simulator {
//    static var groupSizes = [3,5,7,9,11,13]
    static var mutationRates = [1,5,10,15,20,25]
    static var simulationResults : [SimulatorResults] = []
    static let selectionTypes = [SelectionType.rouletteWheel, SelectionType.tournament]

    static var currentIndex = 0
    
    static func makeValues(population: [Solution]) {
        let sortedSolutions = Selection.sortBySolutionScore(solutions: population)
        let min : CGFloat = (sortedSolutions.first?.score.distance)!
        let max : CGFloat = (sortedSolutions.last?.score.distance)!
        let avg : CGFloat = average(nums: sortedSolutions.map({$0.score.distance}))
        
        let newSimulationResults = SimulatorResults(min: min, avg: avg, max: max)
        Simulator.simulationResults.append(newSimulationResults)
    }
    
//    static func getParams() -> [String : Int] {
//        return ["groupSize" : groupSizes[currentIndex]]
//    }
    
    static func printValues() {
        var index = 0
        for simulatorResults in Simulator.simulationResults {
            print(index.description + ";" + simulatorResults.getResultsAsString())
            index += 1
        }
    }
    
    static func average(nums: [CGFloat]) -> CGFloat {
        
        var total = CGFloat(0)
        //use the parameter-array instead of the global variable votes
        for vote in nums{
            
            total += CGFloat(vote)
            
        }
        
        let votesTotal = CGFloat(nums.count)
        let average = total/votesTotal
        return average
    }
}
