
// Move.swift
// Chess
//
// Created by Mete Vesek on 8.02.2024.
//

import Foundation

class Move {
    
    private let bishopDirections = [(-1, -1), (-1, 1), (1, -1), (1, 1)]
    private let rookDirections = [(0, -1), (0, 1), (-1, 0), (1, 0)]
    private let queenDirections = [(-1, -1), (-1, 1), (1, -1), (1, 1), (0, -1), (0, 1), (-1, 0), (1, 0)]
    
    func canMove(piece: Piece, to targetCoords: IndexPath, on board: Board) -> Bool {
        let targetPiece = board.pieceAt(indexPath: targetCoords)
        if board.isEmpty(at: targetCoords) {
            return true
        } else if let targetPiece = targetPiece, targetPiece.color != piece.color {
            return true
        } else {
            return false
        }
    }
    
    func possibleMoves(piece: Piece, from currentCoords: IndexPath, on board: Board) -> [IndexPath] {
        var moves: [IndexPath] = []
        switch piece.type {
        case .pawn:
            moves = pawnMoves(piece: piece, from: currentCoords, on: board)
        case .knight:
            moves = knightMoves(from: currentCoords, on: board)
        case .bishop:
            moves = slidingPieceMoves(directions: bishopDirections, from: currentCoords, on: board, piece: piece)
        case .rook:
            moves = slidingPieceMoves(directions: rookDirections, from: currentCoords, on: board, piece: piece)
        case .queen:
            moves = slidingPieceMoves(directions: queenDirections, from: currentCoords, on: board, piece: piece)
        case .king:
            moves = kingMoves(from: currentCoords, on: board, piece: piece)
        }
        return moves.filter { canMove(piece: piece, to: $0, on: board) }
    }
    
    private func pawnMoves(piece: Piece, from currentCoords: IndexPath, on board: Board) -> [IndexPath] {
        var moves: [IndexPath] = []
        let direction = piece.color == .white ? -1 : 1
        let startRow = piece.color == .white ? 6 : 1
        let oneStepForwardIndex = currentCoords.item + direction * 8
        
        if oneStepForwardIndex >= 0 && oneStepForwardIndex < 64 {
            let oneStepForward = IndexPath(item: oneStepForwardIndex, section: currentCoords.section)
            if board.isEmpty(at: oneStepForward) {
                moves.append(oneStepForward)
                
                if currentCoords.item / 8 == startRow {
                    let twoStepsForwardIndex = currentCoords.item + 2 * direction * 8
                    if twoStepsForwardIndex >= 0 && twoStepsForwardIndex < 64 {
                        
                        let twoStepsForward = IndexPath(item: twoStepsForwardIndex, section: currentCoords.section)
                        if board.isEmpty(at: twoStepsForward) {
                            moves.append(twoStepsForward)
                        }
                    }
                }
            }
        }

        let attackMoves = [(-1, direction), (1, direction)]
        for (dx, dy) in attackMoves {
            let diagIndex = currentCoords.item + dx + dy * 8
            if diagIndex >= 0 && diagIndex < 64 {
                let diagTarget = IndexPath(item: diagIndex, section: currentCoords.section)
                if let targetPiece = board.pieceAt(indexPath: diagTarget), targetPiece.color != piece.color {
                    moves.append(diagTarget)
                }
            }
        }
        
        return moves
    }
    
    private func knightMoves(from currentCoords: IndexPath, on board: Board) -> [IndexPath] {
        let moves = [(-2, -1), (-2, 1), (-1, -2), (-1, 2), (1, -2), (1, 2), (2, -1), (2, 1)].compactMap { dx, dy in
            offset(indexPath: currentCoords, dx: dx, dy: dy)
        }
        return moves
    }
    
    private func slidingPieceMoves(directions: [(Int, Int)], from currentCoords: IndexPath, on board: Board, piece: Piece) -> [IndexPath] {
        var moves: [IndexPath] = []
        for (dx, dy) in directions {
            var nextCoords = offset(indexPath: currentCoords, dx: dx, dy: dy)
            while let next = nextCoords, board.isEmpty(at: next) {
                moves.append(next)
                nextCoords = offset(indexPath: next, dx: dx, dy: dy)
            }
            if let next = nextCoords, board.pieceAt(indexPath: next)?.color != piece.color {
                moves.append(next)
            }
        }
        return moves
    }
    
    private func kingMoves(from currentCoords: IndexPath, on board: Board, piece: Piece) -> [IndexPath] {
        queenDirections.compactMap { dx, dy in
            offset(indexPath: currentCoords, dx: dx, dy: dy)
        }
    }
    
    private func offset(indexPath: IndexPath, dx: Int, dy: Int) -> IndexPath? {
        let row = indexPath.item / 8 + dx
        let col = indexPath.item % 8 + dy
        if row >= 0, row < 8, col >= 0, col < 8 {
            return IndexPath(item: row * 8 + col, section: indexPath.section)
        }
        return nil
    }
}
