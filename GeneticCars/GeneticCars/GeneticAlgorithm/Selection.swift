//
//  Selection.swift
//  GeneticCars
//
//  Created by Sebastian Kotarski on 18.11.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import Foundation
import CoreGraphics

struct Selection {
    
    static func selectSolutionsWithSelectionType(solutions: [Solution], selectionType: SelectionTypes, _ params: [String : Int]?) -> Solution {
        switch selectionType {
        case .rouletteWheel:
            let sumOfAllQualityFunctions : CGFloat = solutions.reduce(CGFloat(0), { (acc, solution) -> CGFloat in
                var sum = acc
                sum += solution.score?.getCombinatedScore() ?? CGFloat(0)
                return sum
            })
            let probabilitiesForSolutions = solutions.map({($0.score?.getCombinatedScore())! / sumOfAllQualityFunctions})
            let randomValue = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
            
            var index = 0
            var accSum = CGFloat(0)
            
            for currentValue in probabilitiesForSolutions {
                if accSum <= randomValue {
                    accSum += currentValue
                    index += 1
                } else {
                    break
                }
            }
            if index >= solutions.count {
                return solutions.last!
            }
            let selectedSolution = solutions[index]
            return selectedSolution
        case .tournament:
            let groupSize : Int = (params?["groupSize"])!
            var solutionsWithoutChoosen = solutions
            var newGroup : [Solution] = []
            for _ in 1...groupSize {
                let randomIndex = Utilities.sharedInstance.randomNumber(inRange: 0...solutionsWithoutChoosen.count - 1)
                let randomlySelectedSolution = solutionsWithoutChoosen[randomIndex]
                solutionsWithoutChoosen.remove(at: randomIndex)
                newGroup.append(randomlySelectedSolution)
            }
            newGroup = sortBySolutionScore(solutions: newGroup)
            return newGroup.last!
        }
    }
    
    static func sortBySolutionScore(solutions: [Solution]) -> [Solution] {
        return solutions.sorted(by: {($0.score)! > ($1.score)!})
    }
}
