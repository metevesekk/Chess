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
    
    init(type: PieceType, color: PieceColor, isAlive: Bool, index: IndexPath) {
        self.color = color
        self.type = type
        self.isAlive = isAlive
        self.index = index
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
