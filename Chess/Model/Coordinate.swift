//
//  Coordinate.swift
//  Chess
//
//  Created by Mete Vesek on 11.02.2024.
//

import Foundation

struct Coordinate : Equatable, Hashable {
    var column: Int
    var row: Int
    
    static func ==(lhs:Coordinate, rhs:Coordinate) -> Bool {
        var bool = Bool()
        if lhs.row == rhs.row && lhs.column == rhs.column {
            bool = true
        } else {
            bool = false
        }
        return bool
    }
}
