//
//  GameOfLife.swift
//  GameOfLife
//
//  Created by Александр Шушков on 25.02.2023.
//
import AppKit
import Combine

class GameOfLife: ObservableObject {
  let nextStep = PassthroughSubject<Void, Never>()

  var cancellable: AnyCancellable?

  @Published private(set) var board: Board
  @Published var isPlaying: Bool = false

  init(width: Int, height: Int) {
    board = Board(width: width, height: height)
  }

  func toggleCellAt(rowIndex: Int, columnIndex: Int) {
    board.toggleCellAt(rowIndex: rowIndex, columnIndex: columnIndex)
  }

  func nextStep(onCompleted: (() -> Void)? = nil) {
    board.nextStep()
    onCompleted?()
  }

  func clear() {
    isPlaying = false
    cancellable = nil

    board.clear()
  }

  func randomize() {
    isPlaying = false
    cancellable = nil

    board.randomize()
  }
}
