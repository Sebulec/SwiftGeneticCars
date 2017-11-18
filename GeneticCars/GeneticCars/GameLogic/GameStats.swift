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
    private var numberOfPopulation = 0
    private var _vehiclesWithScores: [Vehicle : CGFloat] = [:]
    var vehiclesWithScores: [Vehicle : CGFloat] {
        get {
            return _vehiclesWithScores
        }
        set {
            _vehiclesWithScores = newValue
            bestScore = self.vehiclesWithScores.values.max()!
        }
    }
    private var bestScore: CGFloat = CGFloat(0)
    private var bestScoreOfAllTime: CGFloat = CGFloat(0)
    
    func getLabelInfo() -> String {
        return "Population: " + numberOfPopulation.description + "\n"
            + "Best score: " + String(format: "%.2f", bestScore / 100.0) + "\n"
            + "Best score of all: " +  String(format: "%.2f", bestScoreOfAllTime / 100.0)
    }
    
}
