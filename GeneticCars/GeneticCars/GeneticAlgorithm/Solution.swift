//
//  Solution.swift
//  GeneticCars
//
//  Created by Sebastian Kotarski on 11.11.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import CoreGraphics

class Solution {
    var positionCoordinatesGenes: [CGFloat] = []
    var wheelIndexesGenes: [Int] = []
    var wheelRadiusGenes: [CGFloat] = []
    
    var score: SolutionScore = SolutionScore()
    
    init() {
        for _ in 0...GameRules.numberOfPointsInSolution*2 - 1 {
            positionCoordinatesGenes.append(CGFloat(0))
        }
        for _ in 0...GameRules.numberOfWheelsInSolution - 1 {
            wheelIndexesGenes.append(0)
        }
        for _ in 0...GameRules.numberOfWheelsInSolution - 1 {
            wheelRadiusGenes.append(CGFloat(0))
        }
    }
    
    init(positionCoordinatesGenes: [CGFloat], wheelIndexesGenes: [Int], wheelRadiusGenes: [CGFloat]) {
        self.positionCoordinatesGenes = positionCoordinatesGenes
        self.wheelIndexesGenes = wheelIndexesGenes
        self.wheelRadiusGenes = wheelRadiusGenes
    }
    
    func fixGenesIfBroken() {
        for index in 0...GameRules.numberOfPointsInSolution*2 - 1 {
            var positionCoordinateGene = self.positionCoordinatesGenes[index]
            if index % 2 == 0 {
                // horizontal
                if positionCoordinateGene > CGFloat(GameRules.coordinatesRangeForHorizontal) {
                    positionCoordinateGene = CGFloat(GameRules.coordinatesRangeForHorizontal)
                } else if positionCoordinateGene < CGFloat(-GameRules.coordinatesRangeForHorizontal) {
                    positionCoordinateGene = CGFloat(-GameRules.coordinatesRangeForHorizontal)
                }
            } else {
                // vertical
                if positionCoordinateGene > CGFloat(GameRules.coordinatesRangeForVertical) {
                    positionCoordinateGene = CGFloat(GameRules.coordinatesRangeForVertical)
                } else if positionCoordinateGene < CGFloat(-GameRules.coordinatesRangeForVertical) {
                    positionCoordinateGene = CGFloat(-GameRules.coordinatesRangeForVertical)
                }
            }
            self.positionCoordinatesGenes[index] = positionCoordinateGene
        }
        for index in 0...GameRules.numberOfWheelsInSolution - 1 {
            var wheelPosition = wheelIndexesGenes[index]
            if wheelPosition > GameRules.numberOfPointsInSolution - 1 {
                wheelPosition = GameRules.numberOfPointsInSolution - 1
            } else if wheelPosition < 0 {
                wheelPosition = 0
            }
            wheelIndexesGenes[index] = wheelPosition
        }
        for index in 0...GameRules.numberOfWheelsInSolution - 1 {
            var wheelRadius = wheelRadiusGenes[index]
            if wheelRadius > GameRules.wheelSizeRange {
                wheelRadius = GameRules.wheelSizeRange
            } else if wheelRadius < 1 {
                wheelRadius = 1
            }
            wheelRadiusGenes[index] = wheelRadius
        }
    }
}
