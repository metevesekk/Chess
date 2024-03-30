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
    func toDictionary() -> [String: Any] {
        return [
            "color": color.rawValue,
            "type": type.rawValue,
            "isAlive": isAlive,
            "indexSection": index.section,
            "indexItem": index.item,
            "moveCount": moveCount
        ]
    }
    
    static func fromDictionary(_ dictionary: [String: Any]) -> Piece? {
        guard let colorRawValue = dictionary["color"] as? String,
              let typeRawValue = dictionary["type"] as? String,
              let isAlive = dictionary["isAlive"] as? Bool,
              let indexSection = dictionary["indexSection"] as? Int,
              let indexItem = dictionary["indexItem"] as? Int,
              let moveCount = dictionary["moveCount"] as? Int,
              let color = PieceColor(rawValue: colorRawValue),
              let type = PieceType(rawValue: typeRawValue) else {
            return nil
        }
        
        let index = IndexPath(item: indexItem, section: indexSection)
        return Piece(type: type, color: color, isAlive: isAlive, index: index, moveCount: moveCount)
    }
}
