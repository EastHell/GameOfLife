//
//  GameView.swift
//  GameOfLife
//
//  Created by Александр Шушков on 25.02.2023.
//

import Combine
import SwiftUI

struct GameView: View {
  @ObservedObject var game: GameOfLife

  var body: some View {
    VStack {
      gameView
      Spacer()
      HStack {
        Spacer()
        clearButton
        Spacer()
        playButton
        Spacer()
        randomizeButton
        Spacer()
      }
      Spacer()
    }
  }

  private var gameView: some View {
    VStack(spacing: .zero) {
      ForEach(Array(game.board.cells.enumerated()), id: \.0) { rowIndex, row in
        HStack(spacing: .zero) {
          ForEach(Array(row.enumerated()), id: \.0) { columnIndex, cell in
            Rectangle()
              .fill(cell == .alive ? .black : .white)
              .frame(width: 750 / CGFloat(game.board.width), height: 750 / CGFloat(game.board.height))
              .onTapGesture {
                game.toggleCellAt(rowIndex: rowIndex, columnIndex: columnIndex)
              }
          }
        }
      }
    }
  }

  private var playButton: some View {
    Button(game.isPlaying ? "Pause" : "Play") {
      game.isPlaying = !game.isPlaying

      if game.isPlaying {
        game.cancellable = game.nextStep
          .delay(for: .milliseconds(1), scheduler: RunLoop.main)
          .sink(receiveValue: { _ in
            game.nextStep()
            game.nextStep.send()
          })

        game.nextStep.send()
      } else {
        game.cancellable = nil
      }
    }
  }

  private var clearButton: some View {
    Button("Clear") {
      game.clear()
    }
  }

  private var randomizeButton: some View {
    Button("Randomize") {
      game.randomize()
    }
  }
}

struct GameView_Previews: PreviewProvider {
  static var previews: some View {
    GameView(game: GameOfLife(width: 15, height: 15))
  }
}
