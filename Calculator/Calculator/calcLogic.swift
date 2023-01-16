//
//  calcLogic.swift
//  Calculator
//
//  Created by hangeonhui on 2023/01/17.
//

import Foundation

class CalcLogin {
    
    var digit1 : Double? = nil
    var digit2 : Double? = nil
    var calculatResult: Double? = nil
    var rememverSymbol: String? = nil
    
    func logic() -> Double? {
        switch rememverSymbol {
        case "+":
            calculatResult = digit1! + digit2!
        case "-":
            calculatResult = digit1! - digit2!
        case "+-":
            calculatResult = -digit1!
        case "%":
            calculatResult = digit1! * 0.01
            
        default:
            break
        }
     
        return calculatResult
    }
}
