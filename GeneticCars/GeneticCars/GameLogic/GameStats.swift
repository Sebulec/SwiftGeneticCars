//
//  GameStats.swift
//  GeneticCars
//
//  Created by Sebastian Kotarski on 11.11.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import SpriteKit
import GameKit

struct GameStats {
    private var geneticAlgorithm: GeneticAlgorithm?
    private var _vehiclesWithScores: [Vehicle : CGFloat] = [:]
    var vehiclesWithScores: [Vehicle : CGFloat] {
        get {
            return _vehiclesWithScores
        }
        set {
            _vehiclesWithScores = newValue
            bestScore = self.vehiclesWithScores.values.max() ?? 0
            bestScoreOfAllTime = self.geneticAlgorithm?.bestSolutionOfAllTime?.score.distance ?? 0.0
        }
    }
    private var bestScore: CGFloat = CGFloat(0)
    private var bestScoreOfAllTime: CGFloat = CGFloat(0)
    
    func getLabelInfo() -> String {
        let populationSize = "Population: " + (geneticAlgorithm?.numberOfIteration.description)!
        return populationSize + "\n"
            + "Best score: " + String(format: "%.2f", bestScore / 100.0) + "\n"
            + "Best score of all: " +  String(format: "%.2f", bestScoreOfAllTime / 100.0)
    }
    
    init(geneticAlgorithm: GeneticAlgorithm) {
        self.geneticAlgorithm = geneticAlgorithm
    }
}
