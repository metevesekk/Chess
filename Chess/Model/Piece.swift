//
//  Piece.swift
//  Chess
//
//  Created by Mete Vesek on 8.02.2024.
//

import Foundation
import CoreData

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

enum PieceType: String {
    case pawn, knight, bishop, rook, queen, king
}

enum PieceColor: String {
    case white, black
}

extension Piece {
    func toCoreData(context: NSManagedObjectContext) -> CDPiece {
        let cdPiece = CDPiece(context: context)
        cdPiece.color = self.color.rawValue
        cdPiece.type = self.type.rawValue
        cdPiece.isAlive = self.isAlive
        cdPiece.indexPath = self.index.archive()
        cdPiece.moveCount = Int16(self.moveCount)
        return cdPiece
    }
    
    static func fromCoreData(cdPiece: CDPiece) -> Piece? {
        guard let color = PieceColor(rawValue: cdPiece.color),
              let type = PieceType(rawValue: cdPiece.type),
              let indexPath = IndexPath.unarchive(data: cdPiece.indexPath) else { return nil }
        
        return Piece(type: type, color: color, isAlive: cdPiece.isAlive, index: indexPath, moveCount: Int(cdPiece.moveCount))
    }
}
