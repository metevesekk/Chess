//
//  Piece.swift
//  Chess
//
//  Created by Mete Vesek on 8.02.2024.
//

import Foundation
import RealmSwift

class Piece{
    let color: PieceColor
    let type: PieceType
    var isAlive: Bool
    var index : IndexPath
    var moveCount : Int
    
    init(type: PieceType, color: PieceColor, isAlive: Bool, index: IndexPath, moveCount: Int) {
        self.color = color
        self.type = type
        self.isAlive = isAlive
        self.index = index
        self.moveCount = moveCount
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

enum PieceType {
    case pawn
    case knight
    case bishop
    case rook
    case queen
    case king
}


enum PieceColor {
    case white
    case black
}
