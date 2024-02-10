//
//  Board.swift
//  Chess
//
//  Created by Mete Vesek on 8.02.2024.
//

import Foundation
import RealmSwift

class Board {
    var pieces: [Piece?]

    init() {
        pieces = Array(repeating: nil, count: 64)
        setupPawns()
        setupBackRows()
    }
    
    private func setupPawns() {
        for index in 8..<16 {
            pieces[index] = Piece(type: .pawn, color: .black)
        }
        for index in 48..<56 {
            pieces[index] = Piece(type: .pawn, color: .white)
        }
    }
    
    private func setupBackRows() {
        let backRowTypes: [PieceType] = [.rook, .knight, .bishop, .king, .queen, .bishop, .knight, .rook]
        
        for (index, type) in backRowTypes.enumerated() {
            pieces[index] = Piece(type: type, color: .black)
            pieces[56 + index] = Piece(type: type, color: .white)
        }
    }
}

