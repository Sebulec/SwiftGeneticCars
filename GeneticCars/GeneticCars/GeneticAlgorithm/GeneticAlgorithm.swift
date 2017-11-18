//
//  GeneticAlgorithm.swift
//  GeneticCars
//
//  Created by Sebastian Kotarski on 18.11.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import Foundation

class GeneticAlgorithm {
    var populationSize = 10
    var numberOfIteration = 0
    
    func getNextPopulation() -> [Solution] {
        //create population
        while shouldStop() {
            
        }
        // todo
        return []
    }
    
    func shouldStop() -> Bool {
        // todo MAX_ITER/minimum quality?
        return false
    }
    
}
