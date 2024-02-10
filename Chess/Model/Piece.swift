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
    
    init(type: PieceType, color: PieceColor) {
        self.color = color
        self.type = type
        self.isAlive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
