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
            pieces[index] = Piece(type: .pawn, color: .black, isAlive: true, index: IndexPath(index: index))
        }
        for index in 48..<56 {
            pieces[index] = Piece(type: .pawn, color: .white, isAlive: true, index: IndexPath(index: index))
        }
    }
    
    private func setupBackRows() {
        let backRowTypes: [PieceType] = [.rook, .knight, .bishop, .king, .queen, .bishop, .knight, .rook]
        
        for (index, type) in backRowTypes.enumerated() {
            pieces[index] = Piece(type: type, color: .black, isAlive: true, index: IndexPath(index: index))
            pieces[56 + index] = Piece(type: type, color: .white, isAlive: true, index: IndexPath(index: index))
        }
    }
    
    func getNotation(number: Int) -> String {
        let columnLetters = ["a", "b", "c", "d", "e", "f", "g", "h"]
        let column = number % 8
        let row = number / 8 + 1
        
        if column < 0 || column >= columnLetters.count || row < 1 || row > 8 {
            return "index bulunamadı"
        }
        
        let notation = "\(columnLetters[column])\(row)"
        return notation
    }

}

