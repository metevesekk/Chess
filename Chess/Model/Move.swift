//
//  Move.swift
//  Chess
//
//  Created by Mete Vesek on 8.02.2024.
//

import Foundation
import RealmSwift

class Move : Board{

    func movePiece(from oldIndex: Int, to newIndex: Int) {
        guard let pieceToMove = pieces[oldIndex] else { return }
        guard oldIndex != newIndex, oldIndex >= 0, oldIndex < pieces.count,
              newIndex >= 0, newIndex < pieces.count,
              pieces[newIndex] == nil, canMove(with: pieceToMove, from: oldIndex, to: newIndex) == true else { return }
          
          pieces[newIndex] = pieceToMove
          pieces[oldIndex] = nil
      }
    
    func canMove(with piece: Piece, from oldIndex: Int, to newIndex: Int) -> Bool{
        var bool = Bool()
        let possibleMoves = possibleMoves(with: piece, from: oldIndex)
        
        if possibleMoves.contains(newIndex){
            bool = true
        } else{
            bool = false
        }
        
        return bool
    }
    
    func possibleMoves(with piece: Piece, from oldIndex: Int) -> Set<Int> {
        let possibleIndexes = Set<Int>()
        var index = Int()
        
        
        return possibleIndexes
    }
    
    
    func getCoord(index: Int) -> Coordinate{
        var coord = Coordinate(column: 0, row: 8)
        
        if index <= 8 {
            for i in 0...index{
                coord.row += 1
            }
        } else{
            for i in 0...index / 8{
                coord.column -= 1
                for j in 0...8{
                    coord.row += 1
                }
            }
        }

        return coord
    }
        
}
