//
//  Move.swift
//  Chess
//
//  Created by Mete Vesek on 8.02.2024.
//

import Foundation
import RealmSwift

class Move : Board{

    func movePiece(from oldIndex: Coordinate, to newIndex: Coordinate) {
        guard let pieceToMove = pieces[getIndex(coord: oldIndex)] else { return }
        guard getCoord(index: getIndex(coord: newIndex)) != getCoord(index: getIndex(coord: newIndex)), getIndex(coord: oldIndex) >= 0, getIndex(coord: oldIndex) < pieces.count,
              getIndex(coord: newIndex) >= 0, getIndex(coord: newIndex) < pieces.count,
              pieces[getIndex(coord: newIndex)] == nil, canMove(with: pieceToMove, from: oldIndex, to: newIndex) == true else { return }
          
          pieces[getIndex(coord: newIndex)] = pieceToMove
          pieces[getIndex(coord: oldIndex)] = nil
      }
    
    func canMove(with piece: Piece, from oldIndex: Coordinate, to newIndex: Coordinate) -> Bool{
        var bool = Bool()
        let possibleMoves = possibleMoves(with: piece, from: oldIndex)
        
        if possibleMoves.contains(newIndex){
            bool = true
        } else{
            bool = false
        }
        
        return bool
    }
    
    func possibleMoves(with piece: Piece, from currentCoords: Coordinate) -> Set<Coordinate> {
        var possibleIndexes = Set<Coordinate>()
        var coords = currentCoords
        if piece.color == .white{
            switch piece.type{
            case .pawn:
                possibleIndexes.insert(Coordinate(column: currentCoords.column , row: currentCoords.row - 1))
            case .queen:
                possibleIndexes.insert(Coordinate(column: currentCoords.column , row: currentCoords.row - 1))
            case .king:
                possibleIndexes.insert(Coordinate(column: currentCoords.column , row: currentCoords.row - 1))
            case .bishop:
                possibleIndexes.insert(Coordinate(column: currentCoords.column , row: currentCoords.row - 1))
            case .knight:
                possibleIndexes.insert(Coordinate(column: currentCoords.column , row: currentCoords.row - 1))
            case .rook:
                possibleIndexes.insert(Coordinate(column: currentCoords.column , row: currentCoords.row - 1))
            }
        }
        
        return possibleIndexes
    }
    
    
    func getCoord(index: Int) -> Coordinate{
        var coord = Coordinate(column: 0, row: 8)
        
        if index <= 8 {
            for _ in 0...index{
                coord.row += 1
            }
        } else{
            for _ in 0...index / 8{
                coord.column -= 1
                for _ in 0...8{
                    coord.row += 1
                }
            }
        }

        return coord
    }
    
    func getIndex(coord: Coordinate) -> Int{
        let x = coord.column
        let y = coord.row
        return 8 * y + x
    }
        
}
