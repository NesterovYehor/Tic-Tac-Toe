//
//  ContentView.swift
//  Tic-Tac-Toe
//
//  Created by Егор  on 04.07.2022.
//

import SwiftUI

struct TicTacToeBoardView: View {
    @EnvironmentObject var vm: BoardViewModel
        var body: some View {
        GeometryReader { geometry in
            VStack{
                Spacer()
                LazyVGrid(columns: vm.columns, spacing: 13) {
                    ForEach(0..<9) { i in
                        ZStack{
                            Rectangle()
                                .foregroundColor(Color("background"))
                                .frame(width: geometry.size.width/3.3,
                                       height: geometry.size.width/3.3)
                            Image(systemName: vm.moves[i]?.indicator ?? "")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                        .onTapGesture {
                            playerMakeAMove(index: i, in: vm.moves)
                            
                            // Check for win or deaw
                            if vm.checkWinCondition(for: .human, in: vm.moves){
                                vm.alert = vm.humanWin
                                return
                                
                            }
                            if vm.checkDrawCondition(in: vm.moves){
                                vm.alert = vm.draw
                                vm.isBoardDisable = false
                                return
                                
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                computerMakeAMove(in: vm.moves)
                                
                                if vm.checkWinCondition(for: .computer, in: vm.moves){
                                    vm.alert = vm.computerWin
                                    return
                                    
                                }
                            }
                            
                        }
                    }.padding(.vertical, -1)
                }
                .background(Color.white)
                .padding()
                Spacer()
            }
            .disabled(vm.isBoardDisable)
            .alert(item: $vm.alert) { alert in
                Alert(title: alert.title, message: alert.massage, dismissButton: .default(alert.buttonTitle, action: vm.resetGame))
            }
            
        }
        .background(Color("background"))
    }
}

extension TicTacToeBoardView{
    private func playerMakeAMove(index: Int, in moves: [Move?]){
        if vm.isSquareOccupated(in: vm.moves, forIndex: index) { return }
        vm.moves[index] = Move(player: .human, boardIndex: index)
        vm.isBoardDisable = true
        
       
    }
    
    private func computerMakeAMove(in moves: [Move?]){
            let computerPosition = vm.determineComputerMovePosetion(in: vm.moves)
            vm.moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
        vm.isBoardDisable = false

    
    }
}


struct TicTacToeBoardView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeBoardView()
            .environmentObject(BoardViewModel())
    }
}
