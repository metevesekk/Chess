//
//  Player.swift
//  Chess
//
//  Created by Mete Vesek on 8.02.2024.
//

import Foundation
import RealmSwift

struct Player{
    var nickname : String
    var isCurrentPlayer: Bool
    var colorPlayer: PlayerColor
    
}

enum PlayerColor {
    case white, black
}
