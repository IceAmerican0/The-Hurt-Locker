//
//  MineField.swift
//  TheHurtLocker
//
//  Created by 박성준 on 2023/04/10.
//

import Foundation

public struct Board {
    let width: Int
    let height: Int
    var cells: [[Cell]]

    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        self.cells = Array(repeating: Array(repeating: Cell(), count: height), count: width)
        self.cells = createMines(in: self.cells)
    }

    private func createMines(in cells: [[Cell]]) -> [[Cell]] {
        var updatedCells = cells
        let numberOfMines = Int(Double(width * height) * 0.15)
        for _ in 0..<numberOfMines {
            var randomRow = Int.random(in: 0..<height)
            var randomColumn = Int.random(in: 0..<width)
            while updatedCells[randomColumn][randomRow].isMine {
                randomRow = Int.random(in: 0..<height)
                randomColumn = Int.random(in: 0..<width)
            }
            updatedCells[randomColumn][randomRow].isMine = true
        }
        return updatedCells
    }
}

public struct Cell {
    var isMine: Bool = false
    var isRevealed: Bool = false
    var isFlagged: Bool = false
    var surroundingMines: Int = 0
}
