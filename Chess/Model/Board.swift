//
//  Board.swift
//  Chess
//
//  Created by Mete Vesek on 8.02.2024.
//

import Foundation
import RealmSwift

class Board {
    
    var pieces : [Piece?]
    
    init() {
        pieces = Array(repeating: nil, count: 64)
        
        for index in 8..<16{
            pieces[index] = Piece(type: .pawn, color: .black)
        }
        
        for index in 48..<56{
            pieces[index] = Piece(type: .pawn, color: .white)
        }
        
        for index in 0...8{
            switch index{
            case 0 :
                pieces[index] = Piece(type: .rook, color: .black)
            case 1 :
                pieces[index] = Piece(type: .knight, color: .black)
            case 2 :
                pieces[index] = Piece(type: .bishop, color: .black)
            case 3 :
                pieces[index] = Piece(type: .king, color: .black)
            case 4 :
                pieces[index] = Piece(type: .queen, color: .black)
            case 5 :
                pieces[index] = Piece(type: .bishop, color: .black)
            case 6 :
                pieces[index] = Piece(type: .knight, color: .black)
            case 7 :
                pieces[index] = Piece(type: .rook, color: .black)
            default:
                break
            }
        }
        
        for index in 56...63{
            switch index{
            case 56 :
                pieces[index] = Piece(type: .rook, color: .white)
            case 57 :
                pieces[index] = Piece(type: .knight, color: .white)
            case 58 :
                pieces[index] = Piece(type: .bishop, color: .white)
            case 59 :
                pieces[index] = Piece(type: .king, color: .white)
            case 60 :
                pieces[index] = Piece(type: .queen, color: .white)
            case 61 :
                pieces[index] = Piece(type: .bishop, color: .white)
            case 62 :
                pieces[index] = Piece(type: .knight, color: .white)
            case 63 :
                pieces[index] = Piece(type: .rook, color: .white)
            default:
                break
            }
        }
    }
    
}
