//
//  File.swift
//  
//
//  Created by sml on 10/04/23.
//

import SwiftUI
import ARKit
import RealityKit
import Combine

class CustomARView: ARView {
    var ballEntity = ModelEntity(mesh: .generateSphere(radius: 0.2),
                           materials: [SimpleMaterial(color: .white, isMetallic: false)])
    var ballWorldAnchor = AnchorEntity()
    var gameRounds: GameLogic?
    var puzzleAnchorEntity = AnchorEntity()
    var currentColor: CustomColor = .white
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(gameRounds: GameLogic) {
        self.init(frame: UIScreen.main.bounds)
        let worldAnchor = AnchorEntity()
        puzzleAnchorEntity = worldAnchor
        subscribeToActionStream(worldAnchor: worldAnchor)
        self.gameRounds = gameRounds
    }
    
    private var cancellables: Set<AnyCancellable> = []

    func subscribeToActionStream(worldAnchor: AnchorEntity) {
        ARManager.shared
            .actionStream
            .sink { [weak self] action in
                switch action {
                case .rotate(let offset):
                    self?.transformEntity(worldAnchor: worldAnchor, offset: offset)
                case .transform(let offset):
                    self?.transformEntity(worldAnchor: worldAnchor, offset: offset)
                case .play:
                    self?.loadUsdz(file: "puzzle.usdz", worldAnchor: worldAnchor)
                    self?.loadBall(physicalSphere: self!.ballEntity)
                    self?.loadBucket()
                case .updateBall:
                    if (self?.ballEntity.transform.translation.y)! < -50.0 {
                        self?.replaceBallWhenFalling(worldAnchor: worldAnchor)
                    }
                case .changeBallColor:
                    self?.changeBallColor()
                }
            }
            .store(in: &cancellables)
    }
}


