//
//  Move.swift
//  Chess
//
//  Created by Mete Vesek on 8.02.2024.
//

import Foundation
import RealmSwift

class Move : Board{

    
    func canMove(with piece: Piece, from oldIndex: IndexPath, to newIndex: IndexPath) -> Bool{
        var bool = Bool()
        let possibleMoves = possibleMoves(with: piece, from: oldIndex)
        
        if possibleMoves.contains(newIndex){
            bool = true
        } else{
            bool = false
        }
        
        return bool
    }
    
    func possibleMoves(with piece: Piece, from currentCoords: IndexPath) -> Set<IndexPath> {
        var possibleIndexes = Set<IndexPath>()

        // Taşın türüne ve rengine göre olası hareketler
        switch piece.type {
        case .pawn:
            // Piyonlar sadece ileri doğru hareket eder
            let direction = piece.color == .white ? -1 : 1
            let startRow = piece.color == .white ? 6 : 1 // Başlangıç satırı (0-indexed)
            let singleStep = IndexPath(row: currentCoords.row + direction, section: currentCoords.section)
            let doubleStep = IndexPath(row: currentCoords.row + 2 * direction, section: currentCoords.section)
            
            // İlk hareketinde iki kare ilerleyebilir
            if currentCoords.row == startRow {
                possibleIndexes.insert(doubleStep)
            }
            possibleIndexes.insert(singleStep)

        case .knight:
            // Atların L şeklindeki hareketleri
            let moves = [(-2, -1), (-2, 1), (-1, -2), (-1, 2), (1, -2), (1, 2), (2, -1), (2, 1)]
            for move in moves {
                let destination = IndexPath(row: currentCoords.row + move.0, section: currentCoords.section + move.1)
                if destination.row >= 0, destination.row < 8, destination.section >= 0, destination.section < 8 {
                    possibleIndexes.insert(destination)
                }
            }

        case .bishop, .rook, .queen:
            // Fil, kale ve vezir için hareketler
            let directions = piece.type == .bishop ? [(-1, -1), (-1, 1), (1, -1), (1, 1)] :
                             piece.type == .rook ? [(-1, 0), (1, 0), (0, -1), (0, 1)] :
                             [(-1, -1), (-1, 1), (1, -1), (1, 1), (-1, 0), (1, 0), (0, -1), (0, 1)]
            for direction in directions {
                var step = 1
                var destination = IndexPath(row: currentCoords.row + direction.0 * step, section: currentCoords.section + direction.1 * step)
                while destination.row >= 0, destination.row < 8, destination.section >= 0, destination.section < 8 {
                    possibleIndexes.insert(destination)
                    step += 1
                    destination = IndexPath(row: currentCoords.row + direction.0 * step, section: currentCoords.section + direction.1 * step)
                }
            }

        case .king:
            // Kralın bir kare her yöne hareketi
            let moves = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
            for move in moves {
                let destination = IndexPath(row: currentCoords.row + move.0, section: currentCoords.section + move.1)
                if destination.row >= 0, destination.row < 8, destination.section >= 0, destination.section < 8 {
                    possibleIndexes.insert(destination)
                }
            }
        }

        return possibleIndexes
    }

}
