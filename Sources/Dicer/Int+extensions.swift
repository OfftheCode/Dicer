//
//  File.swift
//  
//
//  Created by Piotr Szadkowski on 04/10/2020.
//

import Foundation

extension Int {
    func times(closure: (Int) -> Void) {
        for i in 0..<self {
            closure(i)
        }
    }
}
