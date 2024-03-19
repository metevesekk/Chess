//
//  Game.swift
//  Chess
//
//  Created by Mete Vesek on 8.02.2024.
//

import Foundation
import RealmSwift

class Game{
    var game: [Board]?
    var isGameOver = false
    var moveCount = 0
    
    func getGame(board: Board) -> [Board]?{
        
        while isGameOver{
            if game != nil{
                game?.append(board)
                moveCount += 1
            }
        }
        return game
    }
    
}
