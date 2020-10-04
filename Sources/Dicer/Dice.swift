//
//  File.swift
//  
//
//  Created by Piotr Szadkowski on 04/10/2020.
//

import Foundation

struct Dice {
    var sides: Int

    var rollValue: Int {
        Int.random(in: 1...sides)
    }
    
    init(sides: Int) throws {
        guard sides > 0 else { throw DiceError.wrongValue("Dice value must be greater than 0") }
        self.sides = sides
    }
    
    enum DiceError: Error {
        case wrongValue(String)
    }
}
