//
//  Board.swift
//  GameOfLife
//
//  Created by Александр Шушков on 25.02.2023.
//

struct Board {
  let width: Int
  let height: Int

  private(set) var cells: [[Cell]]

  init(width: Int, height: Int) {
    self.width = width
    self.height = height

    cells = [[Cell]]()

    for row in .zero ..< height {
      cells.append([])
      for _ in .zero ..< width {
        cells[row].append(Bool.random() ? .alive : .dead)
      }
    }
  }

  mutating func nextStep() {
    let newCells = cells.enumerated().map { rowIndex, _ in
      newRow(at: rowIndex)
    }

    cells = newCells
  }

  mutating func toggleCellAt(rowIndex: Int, columnIndex: Int) {
    cells[rowIndex][columnIndex].toggle()
  }

  mutating func clear() {
    cells = cells.map { row in
      row.map { _ in
        .dead
      }
    }
  }

  mutating func randomize() {
    clear()

    for rowIndex in .zero ..< height {
      for columnIndex in .zero ..< width {
        cells[rowIndex][columnIndex] = Bool.random() ? .dead : .alive
      }
    }
  }

  private func newRow(at rowIndex: Int) -> [Cell] {
    cells[rowIndex].enumerated().map { columnIndex, _ in
      newCellAt(rowIndex: rowIndex, columnIndex: columnIndex)
    }
  }

  private func newCellAt(rowIndex: Int, columnIndex: Int) -> Cell {
    let topRowIndex = (rowIndex == 0 ? height : rowIndex) - 1
    let bottomRowIndex = (rowIndex + 1 >= height ? .zero : rowIndex + 1)
    let leftColumnIndex = (columnIndex == 0 ? width : columnIndex) - 1
    let rightColumnIndex = (columnIndex + 1 >= width ? .zero : columnIndex + 1)

    let topLeftCell = cells[topRowIndex][leftColumnIndex]
    let topCell = cells[topRowIndex][columnIndex]
    let topRightCell = cells[topRowIndex][rightColumnIndex]

    let leftCell = cells[rowIndex][leftColumnIndex]
    let rightCell = cells[rowIndex][rightColumnIndex]

    let bottomLeftCell = cells[bottomRowIndex][leftColumnIndex]
    let bottomCell = cells[bottomRowIndex][columnIndex]
    let bottomRightCell = cells[bottomRowIndex][rightColumnIndex]

    let aliveCellsCount = [
      topLeftCell,
      topCell,
      topRightCell,
      leftCell,
      rightCell,
      bottomLeftCell,
      bottomCell,
      bottomRightCell,
    ].reduce(.zero) { partialResult, cell in
      partialResult + (cell == .alive ? 1 : 0)
    }

    return cells[rowIndex][columnIndex].nextCell(nearAliveCount: aliveCellsCount)
  }
}
