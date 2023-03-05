//
//  Cell.swift
//  GameOfLife
//
//  Created by Александр Шушков on 05.03.2023.
//

enum Cell {
  case dead
  case alive

  mutating func toggle() {
    switch self {
    case .dead:
      self = .alive
    case .alive:
      self = .dead
    }
  }

  func nextCell(nearAliveCount: Int) -> Self {
    if self == .alive,
       nearAliveCount < 2
    {
      return .dead
    }

    if self == .alive,
       nearAliveCount > 3
    {
      return .dead
    }

    if nearAliveCount == 3 {
      return .alive
    }

    return self
  }
}
