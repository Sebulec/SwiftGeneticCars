//
//  GameDelegate.swift
//  GeneticCars
//
//  Created by Sebastian Kotarski on 13.11.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import CoreGraphics

protocol GameDelegate: class {
    func didEndedThePopulation(with vehicles: [Vehicle : CGFloat])
    func updateGame(with vehicles: [Vehicle : CGFloat])
}
