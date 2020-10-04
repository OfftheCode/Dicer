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
    
    init(sides: Int) {
        self.sides = sides
    }
}
