//
//  Piece.swift
//  Chess
//
//  Created by Mete Vesek on 8.02.2024.
//

import Foundation
import RealmSwift

class Piece{
    let color : PieceColor
    let type : PieceType
    let isAlive : Bool
    
    var getType : String {
        var typeString = String()
        switch type{
        case .pawn:
            typeString = "pawn"
        case .bishop:
            typeString = "bishop"
        case .rook:
            typeString = "rook"
        case .queen:
            typeString = "queen"
        case .king:
            typeString = "king"
        case .knight:
            typeString = "knight"
        }
        return typeString
    }
    
    var getColor : String {
        var colorString = String()
        switch color{
        case .black:
            colorString = "black"
        case .white:
            colorString = "white"
        }
        return colorString
    }
    
    init(color: PieceColor, type: PieceType) {
        self.color = color
        self.type = type
        self.isAlive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
