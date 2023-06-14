//
//  Tic_Tac_ToeApp.swift
//  Tic-Tac-Toe
//
//  Created by Егор  on 04.07.2022.
//

import SwiftUI

@main
struct Tic_Tac_ToeApp: App {
    var body: some Scene {
        WindowGroup {
            TicTacToeBoardView()
                .environmentObject(BoardViewModel())
        }
    }
}
