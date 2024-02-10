//
//  Board.swift
//  Chess
//
//  Created by Mete Vesek on 8.02.2024.
//

import Foundation
import RealmSwift

class Board {
    
    var pieces : [Piece?]
    
    init() {
        pieces = Array(repeating: nil, count: 64)
        
        for index in 8..<16 {
            pieces[index] = Piece(color: .white, type: .pawn)
        }
    }
    
}
