//
//  Move.swift
//  Tic-Tac-Toe
//
//  Created by Егор  on 04.07.2022.
//

import Foundation

enum Player{
    case human, computer
}

struct Move{
    let player: Player
    let boardIndex: Int
    
    var indicator: String{
        return player == .human ? "xmark" : "circle.fill"
    }
    
}
