//
//  Piece.swift
//  Chess
//
//  Created by Mete Vesek on 8.02.2024.
//

import Foundation
import RealmSwift

class Piece : ChessBoardCell{
    let pieceColor : String? = nil
    let pieceIndex : IndexPath? = nil
    let isAlive = Bool()
    
    enum PieceType{
        case pawn
        case king
        case queen
        case bishop
        case rook
    }
    
    enum PieceColor{
        case black
        case white
    }
    
    func getType(pieceType: PieceType) -> String{
        switch pieceType{
        case .pawn:
            return "pawn"
        case .bishop:
            return "bishop"
        case .rook:
            return "rook"
        case .queen:
            return "queen"
        case .king:
            return "king"
        }
    }
    
    func getColor(pieceColor: PieceColor) -> String{
        switch pieceColor{
        case .black:
            return "black"
        case .white:
            return "white"
        }
    }
}
