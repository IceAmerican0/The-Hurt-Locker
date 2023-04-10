//
//  MineFieldView.swift
//  TheHurtLocker
//
//  Created by 박성준 on 2023/04/08.
//

import SwiftUI

struct MineFieldView: View {
    @State private var board: Board = Board(width: 10, height: 10)
    
    var body: some View {
        VStack {
            ForEach(0..<board.height) { row in
                HStack {
                    ForEach(0..<board.width) { column in
                        Button(action: {
                            print("")
                        }, label: {
                            Image(systemName: board.cells[column][row].isRevealed ? "circle.fill" : "circle")
                        })
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
