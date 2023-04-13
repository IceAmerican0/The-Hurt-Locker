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
                        let isClicked = board.cells[row][column]
                        Button(action: {
                            if isClicked.isRevealed || isClicked.isFlagged {
                                return
                            }
                            
                            if isClicked.isMine {
                                isGameOver = true
                            }
                            
                            board.cells[row][column].isRevealed = true
                        }, label: {
                            if isClicked.isFlagged {
                                Image(systemName: "flag")
                            } else if isClicked.isRevealed {
                                Image(systemName: isClicked.isMine ? "circle.fill" : "1.circle")
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
}

struct MineFieldView_Previews: PreviewProvider {
    static var previews: some View {
        MineFieldView()
    }
}
