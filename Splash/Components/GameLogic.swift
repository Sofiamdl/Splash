//
//  File.swift
//  
//
//  Created by sml on 16/04/23.
//


import SwiftUI

class GameLogic: ObservableObject {
    @Published var counter: Int = 0
    @Published var levels: [CustomColor] = []
    @Published var currentLevel: Int = 0
    @Published var screen: Screen = .home
    
    init() {
        let aux : [CustomColor]  = [.yellow, .red, .blue, .purple, .green, .orange, .brown]
        self.levels.append(aux[Int.random(in: 0...6)])
    }
    
    func getCurrentLevelString() -> String {
        return levels[currentLevel].rawValue
    }
    
    func getCurrentLevel() -> CustomColor {
        return levels[currentLevel]
    }
    
    func didWon(currentColor: CustomColor) -> Bool {
        if currentColor == levels[currentLevel] {
            currentLevel += 1
            if currentLevel == levels.count {
                return true
            }
        }
        return false
    }
    
    func reset() {
        counter = 0
        levels = []
        currentLevel = 0
        screen = .home
        let aux : [CustomColor]  = [.yellow, .red, .blue, .purple, .green, .orange, .brown]
        self.levels.append(aux[Int.random(in: 0...6)])
    }
}
