//
//  MineFieldView.swift
//  TheHurtLocker
//
//  Created by 박성준 on 2023/04/08.
//

import SwiftUI

struct MineFieldView: View {
    @State private var board: Board = Board(width: 10, height: 10)
    @State private var isGameOver = false
    
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
                            
                            if selectedCell.isMine {
                                isGameOver = true
                            }
                            
                            board.cells[row][column].isRevealed = true
                            
                            if selectedCell.neighboringMines == 0 {
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
                                LongPressGesture().onEnded({ _ in board.cells[row][column].isFlagged.toggle() })
                            )
                    }
                }
            }
        }
    }
    
    func NeighboringEmptyCell(row: Int, column: Int) {
        for neighboringRow in -1...1 {
            for neighboringColumn in -1...1 {
                if row + neighboringRow < 0 || row + neighboringRow >= board.width || column + neighboringColumn < 0 || column + neighboringColumn >= board.height {
                    continue
                }
                
                let row = row + neighboringRow
                let column = column + neighboringColumn
                if board.cells[row][column].neighboringMines == 0 {
                    board.cells[row][column].isRevealed = true
//                    self.NeighboringEmptyCell(row: row, column: column)
                }
            }
        }
    }
}

struct MineFieldView_Previews: PreviewProvider {
    static var previews: some View {
        MineFieldView()
    }
}
