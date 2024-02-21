//
//  Move.swift
//  Chess
//
//  Created by Mete Vesek on 8.02.2024.
//

import Foundation

class Move {
    
    var board = Board()
    
    func canMove(with piece: Piece, to targetCoords: IndexPath?) -> Bool{
        var bool = Bool()
        guard let targetCoords = targetCoords else { return false }
        let enemyPiece = board.pieces[targetCoords.item]
        if board.spaces().contains(targetCoords.item){
            bool = true
        } else if board.spaces().contains(targetCoords.item) && enemyPiece?.color != piece.color{
            bool = true
        } else {
            bool = false
        }
        return bool
    }
    
    func possibleMoves(with piece: Piece, from currentCoords: IndexPath) -> Set<IndexPath?> {
        var possibleMoves = Set<IndexPath?>()
        
        let directionOffsets = getDirectionOffsets(for: piece, from: currentCoords)
        
        for direction in directionOffsets {
            var nextCoords = apply(direction: direction, to: currentCoords)
            while isValid(nextCoords) && canMove(with: piece, to: nextCoords){
                possibleMoves.insert(nextCoords)
                
                if piece.type == .pawn || piece.type == .king || piece.type == .knight{
                    break
                }
                
                nextCoords = apply(direction: direction, to: nextCoords!)
            }
        }
        
        return possibleMoves.filter { $0 != nil }
    }
    
    private func getDirectionOffsets(for piece: Piece, from currentCoords: IndexPath) -> [(row: Int, col: Int)] {
        switch piece.type {
        case .pawn:
            let initialRow = piece.color == .black ? 1 : 6
            let moveForward = piece.color == .black ? 1 : -1
            var moves = [(moveForward, 0)]
            if currentCoords.item / 8 == initialRow && piece.moveCount == 0 {
                moves.append((2 * moveForward, 0))
            }
            
        //    moves += [(moveForward, -1), (moveForward, 1)]
            return moves.filter { isValidOffset(currentCoords: currentCoords, offset: $0) }
        case .rook:
            return [(1, 0), (-1, 0), (0, 1), (0, -1)].filter { isValidOffset(currentCoords: currentCoords, offset: $0) }
        case .knight:
            return [(2, 1), (2, -1), (-2, 1), (-2, -1), (1, 2), (1, -2), (-1, 2), (-1, -2)].filter { isValidOffset(currentCoords: currentCoords, offset: $0) }
        case .bishop:
            return [(1, 1), (1, -1), (-1, 1), (-1, -1)].filter { isValidOffset(currentCoords: currentCoords, offset: $0) }
        case .queen, .king:
            return [(1, 0), (-1, 0), (0, 1), (0, -1), (1, 1), (1, -1), (-1, 1), (-1, -1)].filter { isValidOffset(currentCoords: currentCoords, offset: $0) }
        }
    }
}

private func apply(direction: (row: Int, col: Int), to indexPath: IndexPath) -> IndexPath? {
    let row = indexPath.item / 8 + direction.row
    let col = indexPath.item % 8 + direction.col
    if row >= 0 && row < 8 && col >= 0 && col < 8 {
        return IndexPath(item: row * 8 + col, section: indexPath.section)
    } else {
        return nil
    }
}

private func isValid(_ indexPath: IndexPath?) -> Bool {
    guard let indexPath = indexPath else { return false }
    let row = indexPath.item / 8
    let col = indexPath.item % 8
    return row >= 0 && row < 8 && col >= 0 && col < 8
}

private func isValidOffset(currentCoords: IndexPath, offset: (row: Int, col: Int)) -> Bool {
    let currentRow = currentCoords.item / 8
    let currentCol = currentCoords.item % 8
    let newRow = currentRow + offset.row
    let newCol = currentCol + offset.col
    return newRow >= 0 && newRow < 8 && newCol >= 0 && newCol < 8
}

