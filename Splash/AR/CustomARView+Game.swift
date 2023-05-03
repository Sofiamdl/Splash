//
//  File.swift
//  
//
//  Created by sml on 18/04/23.
//

import SwiftUI
import ARKit
import RealityKit
import Combine

extension CustomARView {
    func replaceBallWhenFalling(worldAnchor: AnchorEntity){
        scene.removeAnchor(ballWorldAnchor)
        ballEntity = ModelEntity(mesh: .generateSphere(radius: 0.2),
                               materials: [SimpleMaterial(color: .white, isMetallic: false)])
        ballWorldAnchor = AnchorEntity()
        loadBall(physicalSphere: ballEntity)
        transformEntityWhenChange(worldAnchor: worldAnchor)
        currentColor = .white
    }

    func changeBallColor() {
        let x = ballEntity.transform.translation.x
        let y = ballEntity.transform.translation.y
        let z = ballEntity.transform.translation.z
        if (x < -7.45 && x > -9.2) && (z < 2.3 && z > 1.0) {
            if currentColor == .white {
                changeColor(color: .red)
                currentColor = .red
            } else if currentColor == .blue {
                changeColor(color: .purple)
                currentColor = .purple
            } else if currentColor == .yellow {
                changeColor(color: .orange)
                currentColor = .orange
            } else if currentColor == .green {
                changeColor(color: .brown)
                currentColor = .brown
            }
        } else if (x < 2 && x > -1.3) && (z < 5.0 && z > 4.5) {
            if currentColor == .white {
                changeColor(color: .blue)
                currentColor = .blue
            } else if currentColor == .red {
                changeColor(color: .purple)
                currentColor = .purple
            } else if currentColor == .yellow {
                changeColor(color: .green)
                currentColor = .green
            } else if currentColor == .orange {
                changeColor(color: .brown)
                currentColor = .brown
            }
        } else if (x < -7.5 && x > -9) && (z < 5.5 && z > 4.1) {
            if currentColor == .white {
                changeColor(color: .yellow)
                currentColor = .yellow
            } else if currentColor == .red {
                changeColor(color: .orange)
                currentColor = .orange
            } else if currentColor == .blue {
                changeColor(color: .green)
                currentColor = .green
            } else if currentColor == .purple {
                changeColor(color: .brown)
                currentColor = .brown
            }
        } else if (x < -10.5 && x > -13.5) && (z < 5 && z > 1) && (y < -5.5 && z > -9) {
            let wonGame = gameRounds?.didWon(currentColor: self.currentColor)
            if wonGame! {
                gameRounds?.screen = .gameWon
            }
            replaceBallWhenFalling(worldAnchor: puzzleAnchorEntity)
        }
    }
    
    func changeColor(color: UIColor) {
        let material = SimpleMaterial(color: color, isMetallic: false)
        self.ballEntity.model?.materials[0] = material
    }

}
