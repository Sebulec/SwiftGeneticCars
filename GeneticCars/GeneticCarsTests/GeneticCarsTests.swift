//
//  GeneticCarsTests.swift
//  GeneticCarsTests
//
//  Created by Sebastian Kotarski on 27.11.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import XCTest
@testable import GeneticCars
class GeneticCarsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let geneticAlgorithm = GeneticAlgorithm()
        let solutions = geneticAlgorithm.initializePopulation()
        var index = 1
        solutions.forEach { (solution) in
            let randomValue = index
            solution.score = SolutionScore(time: Utilities.sharedInstance.randomNumber(), distance: CGFloat(randomValue))
            index += 1
        }
        for _ in 1...10 {
            let solution = Selection.selectSolutionsWithSelectionType(solutions: solutions, selectionType: .tournament, ["groupSize" : 5])
            
            let mutatedSolution = Mutation.getMutatedSolution(base: solution, solutions: solutions)
            
            
            let crossOverSolution = Crossover.crossOver(firstSolution: solution, secondSolution: solutions[2])
            print("printed Solution: \(solution.positionCoordinatesGenes)")
            print("printed Solution quality: \(solution.score?.getCombinatedScore())")
        }
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
