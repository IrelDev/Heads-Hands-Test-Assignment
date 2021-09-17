//
//  DoubleReduceScaleExtension.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 18.09.2021.
//

import Foundation

extension Double {
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self
        
        let truncated = Double(Int(newDecimal))
        let originalDecimal = truncated / multiplier
        
        return originalDecimal
    }
}
