//
//  MineFieldView.swift
//  TheHurtLocker
//
//  Created by 박성준 on 2023/04/08.
//

import SwiftUI

struct MineFieldView: View {
    @State private var board: Board = Board(width: 10, height: 10)
    @State private var gameOver = false
    @State private var gameCleared = false
    
    var body: some View {
        VStack {
            ForEach(0..<board.height, id: \.self) { row in
                HStack {
                    ForEach(0..<board.width, id: \.self) { column in
                        let selectedCell = board.cells[row][column]
                        Button(action: {
                            if selectedCell.isRevealed || selectedCell.isFlagged {
                                return
                            }
                            
                            board.cells[row][column].isRevealed = true
                            
                            if selectedCell.isMine {
                                gameOver = true
                            } else if selectedCell.neighboringMines == 0 {
                                NeighboringEmptyCell(row: row, column: column)
                            }
                        }, label: {
                            if selectedCell.isFlagged {
                                Image(systemName: "flag.fill")
                            } else if selectedCell.isRevealed {
                                Image(systemName: selectedCell.isMine ? "circle.fill" : "\(String(selectedCell.neighboringMines)).circle")
                            } else {
                                Image(systemName: "circle")
                            }
                        })
                            .simultaneousGesture(
                                LongPressGesture().onEnded({ _ in
                                    board.cells[row][column].isFlagged.toggle()
                                    
                                    let numberOfMines = Int(Double(board.width * board.height) * 0.15)
                                    var isFlagged = numberOfMines
                                    for row in 0..<board.width {
                                        for column in 0..<board.height {
                                            if board.cells[row][column].isFlagged {
                                                isFlagged += 1
                                            }
                                        }
                                    }
                                    
                                    if isFlagged == numberOfMines {
                                        gameCleared = true
                                    }
                                })
                            )
                            .alert("BOOM!", isPresented: $gameOver) {
                                Button("Retry") {
                                    reset()
                                }
                            } message: {
                                Text("Game Over!!")
                            }
                            .alert("Game Clear!", isPresented: $gameCleared) {
                                Button("") {
                                    reset()
                                }
                            } message: {
                                Text("Well Done!!")
                            }
                    }
                }
            }
        }
    }
    
    func NeighboringEmptyCell(row: Int, column: Int) {
        for neighboringRow in -1...1 {
            for neighboringColumn in -1...1 {
                let row = row + neighboringRow
                let column = column + neighboringColumn
                
                if row < 0 || row >= board.width || column < 0 || column >= board.height {
                    continue
                }
                
                if board.cells[row][column].neighboringMines == 0 {
                    board.cells[row][column].isRevealed = true
//                    self.NeighboringEmptyCell(row: row, column: column)
                }
            }
        }
    }
    
    func reset() {
        board = Board(width: 10, height: 10)
        gameOver = false
        gameCleared = false
    }
}

struct MineFieldView_Previews: PreviewProvider {
    static var previews: some View {
        MineFieldView()
    }
}
