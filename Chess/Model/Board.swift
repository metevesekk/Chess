//
//  Board.swift
//  Chess
//
//  Created by Mete Vesek on 8.02.2024.
//

import Foundation
import RealmSwift

class Board {
    var pieces: [Piece?]

    init() {
        pieces = Array(repeating: nil, count: 64)
        setupPawns()
        setupBackRows()
    }
    
    func pieceAt(indexPath: IndexPath) -> Piece? {
            guard indexPath.item >= 0, indexPath.item < pieces.count else { return nil }
            return pieces[indexPath.item]
        }
        
        func isEmpty(at indexPath: IndexPath) -> Bool {
            pieceAt(indexPath: indexPath) == nil
        }
    
    func spaces() -> Set<Int>{
        var emptyIndexes = Set<Int>()
        for index in 0...63{
            if pieces[index] == nil{
                emptyIndexes.insert(index)
            }
        }
        return emptyIndexes
    }
    
    func movePiece(from sourceIndex: IndexPath, to targetIndex: IndexPath) {
        // Kaynak ve hedef indekslerin uygun aralıkta olduğundan emin olun
        guard sourceIndex.row >= 0, sourceIndex.row < pieces.count,
              targetIndex.row >= 0, targetIndex.row < pieces.count else {
            print("Invalid index")
            return
        }

        // Kaynakta bir taş olup olmadığını kontrol et
        guard let pieceToMove = pieces[sourceIndex.row] else {
            print("No piece at source index")
            return
        }

        // Taşı hedef indekse hareket ettir
        pieces[targetIndex.row] = pieceToMove
        pieces[sourceIndex.row] = nil

        // Taşın konumunu ve hareket sayısını güncelle
        pieces[targetIndex.row]?.index = targetIndex
        pieces[targetIndex.row]?.moveCount += 1
    }

    
    private func setupPawns() {
        for index in 8..<16 {
            pieces[index] = Piece(type: .pawn, color: .black, isAlive: true, index: IndexPath(index: index), moveCount: 0)
        }
        for index in 48..<56 {
            pieces[index] = Piece(type: .pawn, color: .white, isAlive: true, index: IndexPath(index: index), moveCount: 0)
        }
    }
    
    private func setupBackRows() {
        let backRowTypes: [PieceType] = [.rook, .knight, .bishop, .king, .queen, .bishop, .knight, .rook]
        
        for (index, type) in backRowTypes.enumerated() {
            pieces[index] = Piece(type: type, color: .black, isAlive: true, index: IndexPath(index: index), moveCount: 0)
            pieces[56 + index] = Piece(type: type, color: .white, isAlive: true, index: IndexPath(index: index), moveCount: 0)
        }
    }
    
    func getNotation(number: Int) -> String {
        let columnLetters = ["a", "b", "c", "d", "e", "f", "g", "h"]
        let column = number % 8
        let row = number / 8 + 1
        
        if column < 0 || column >= columnLetters.count || row < 1 || row > 8 {
            return "index bulunamadı"
        }
        
        let notation = "\(columnLetters[column])\(row)"
        return notation
    }

}

