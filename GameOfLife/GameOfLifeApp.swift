//
//  GameOfLifeApp.swift
//  GameOfLife
//
//  Created by Александр Шушков on 25.02.2023.
//

import SwiftUI

@main
struct GameOfLifeApp: App {
  var body: some Scene {
    WindowGroup {
      GameView(game: GameOfLife(width: 100, height: 100))
    }
  }
}
