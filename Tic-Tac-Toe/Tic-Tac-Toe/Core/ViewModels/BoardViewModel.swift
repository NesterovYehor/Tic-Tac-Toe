//
//  BoardViewModel.swift
//  Tic-Tac-Toe
//
//  Created by Егор  on 04.07.2022.
//

import Foundation
import SwiftUI

class BoardViewModel: ObservableObject {
    @Published var isBoardDisable: Bool = false
    @Published var alert: AlertItem?
    let columns: [GridItem] = [GridItem(.flexible(), spacing: 25),
                               GridItem(.flexible(), spacing: 25),
                                       GridItem(.flexible())]
    var moves: [Move?] = Array(repeating: nil, count: 9)
    
    let humanWin = AlertItem(title: Text("You win"), massage: Text("You are so smart"), buttonTitle: Text("Lets do this again"))
    
    let computerWin = AlertItem(title: Text("Computer wins"), massage: Text("Maybe in another time"), buttonTitle: Text("Lets try it again"))
    
    let draw = AlertItem(title: Text("Draw"), massage: Text("You were close"), buttonTitle: Text("Lets try it again"))
    
    // MARK: MAKE RESTART OF THE GAME
    func resetGame(){
         moves = Array(repeating: nil, count: 9)
    }
    
    // MARK: CHECK IS SOMEONE WIN
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
                                          [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
         
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPosition = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPosition) {return true}
        
        return false
    }
    
    // MARK: CHECK IS IT DRAW
    func checkDrawCondition(in moves: [Move?]) -> Bool{
        return moves.compactMap { $0 }.count == 9
    }
    
    // MARK: CHECK IA SQUARE IS OCCUPATED
    func isSquareOccupated( in moves: [Move?], forIndex index: Int) -> Bool{
        return moves.contains { $0?.boardIndex == index}
    }
    
    // MARK: DETERMINE COMPUTER MOVE POSITION
    func determineComputerMovePosetion(in moves: [Move?]) -> Int{
        
        // MARK: IF AI CAN WIN, THEN WIN
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
                                          [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
        let computerPosition = Set(computerMoves.map { $0.boardIndex })
        
        for paterns in winPatterns{
            let winPosition = paterns.subtracting(computerPosition)
            if winPosition.count == 1 {
                let isAvaiable = !isSquareOccupated(in: moves, forIndex: winPosition.first!)
                if isAvaiable {
                    return winPosition.first!
                }
            }
        }
        // MARK: IF AI CAN'T WIN, THEN BLOCK
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human }
        let humanPosition = Set(humanMoves.map { $0.boardIndex })
        
        for paterns in winPatterns{
            let blockPosition = paterns.subtracting(humanPosition)
            if blockPosition.count == 1 {
                let isAvaiable = !isSquareOccupated(in: moves, forIndex: blockPosition.first!)
                if isAvaiable {
                    return blockPosition.first!
                }
            }
        }
        
        // MARK: IF AI CAN'T WIN AND CAN'T BLOCK, THEN TAKE MIDLE SQUARE
        let centersquare = 4
        if !isSquareOccupated(in: moves, forIndex: centersquare){
            return centersquare
        }
        
        // MARK: IF AI CAN'T TAKE A MIDLE SQUARE, THEN TAKE RANDOM POSITION
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupated(in: moves, forIndex: movePosition){
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
}


