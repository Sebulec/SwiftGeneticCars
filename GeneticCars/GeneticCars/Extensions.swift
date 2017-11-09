//
//  Extensions.swift
//  GeneticCars
//
//  Created by Sebastian Kotarski on 09.11.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import UIKit

extension CGPoint {
    init(midPointBetweenA a: CGPoint, andB b: CGPoint) {
        self.x = (a.x + b.x) / 2
        self.y = (a.y + b.y) / 2
    }
    func distance(point: CGPoint) -> CGFloat {
        return abs(CGFloat(hypotf(Float(point.x - x), Float(point.y - y))))
    }
}
