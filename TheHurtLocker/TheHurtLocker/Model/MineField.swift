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
        self.cells = Array(repeating: Array(repeating: Cell(), count: width), count: height)
        self.cells = createMines(in: self.cells)
    }

    private func createMines(in cells: [[Cell]]) -> [[Cell]] {
        var updatedCells = cells
        let numberOfMines = Int(Double(width * height) * 0.15)
        for _ in 0..<numberOfMines {
            var randomRow = Int.random(in: 0..<height)
            var randomColumn = Int.random(in: 0..<width)
            while updatedCells[randomRow][randomColumn].isMine {
                randomRow = Int.random(in: 0..<height)
                randomColumn = Int.random(in: 0..<width)
            }
            updatedCells[randomRow][randomColumn].isMine = true
        }
        return countNeighboringMines(cells: updatedCells)
    }
    
    private func countNeighboringMines(cells: [[Cell]]) -> [[Cell]] {
        var updatedCells = cells
        
        for row in 0..<self.width {
            for column in 0..<self.height {
                if updatedCells[row][column].isMine {
                    continue
                }

                var neighboringMines = 0
                
                for neighboringRow in -1...1 {
                    for neighboringColumn in -1...1 {
                        let row = row + neighboringRow
                        let column = column + neighboringColumn
                        
                        if row < 0 || row >= self.width || column < 0 || column >= self.height {
                            continue
                        }

                        if updatedCells[row][column].isMine {
                            neighboringMines += 1
                        }
                    }
                }

                updatedCells[row][column].neighboringMines = neighboringMines
            }
        }
        return updatedCells
    }
}

public struct Cell {
    var isMine: Bool = false
    var isRevealed: Bool = false
    var isFlagged: Bool = false
    var neighboringMines: Int = 0
}
