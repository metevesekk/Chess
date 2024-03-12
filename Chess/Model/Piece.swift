//
//  Piece.swift
//  Chess
//
//  Created by Mete Vesek on 8.02.2024.
//

import Foundation

class Piece {
    let color: PieceColor
    let type: PieceType
    var isAlive: Bool
    var index: IndexPath
    var moveCount: Int
    
    init(type: PieceType, color: PieceColor, isAlive: Bool, index: IndexPath, moveCount: Int) {
        self.color = color
        self.type = type
        self.isAlive = isAlive
        self.index = index
        self.moveCount = moveCount
    }
}

enum PieceType {
    case pawn, knight, bishop, rook, queen, king
}

enum PieceColor {
    case white, black
}
