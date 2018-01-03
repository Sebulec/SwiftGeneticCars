//
//  SimulatorResults.swift
//  GeneticCars
//
//  Created by Sebastian Kotarski on 28.12.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import UIKit

struct SimulatorResults {
    let min: CGFloat
    let avg: CGFloat
    let max: CGFloat
    
    func getResultsAsString() -> String {
        return "\(min);\(avg);\(max)"
    }
}
