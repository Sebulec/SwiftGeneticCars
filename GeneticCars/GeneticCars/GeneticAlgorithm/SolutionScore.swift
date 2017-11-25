//
//  SolutionScore.swift
//  GeneticCars
//
//  Created by Sebastian Kotarski on 25.11.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import Foundation
import CoreGraphics

struct SolutionScore {
    var time: Int = 0
    var distance: CGFloat = 0
    
    func getCombinatedScore() -> CGFloat {
        // todo sth more intelligent
        return CGFloat(time) * distance
    }
    
    static func >(left: SolutionScore, right: SolutionScore) -> Bool {
        return left.getCombinatedScore() > right.getCombinatedScore()
    }
}
