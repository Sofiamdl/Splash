//
//  File.swift
//  
//
//  Created by sml on 11/04/23.
//

import SwiftUI
import ARKit
import RealityKit
import Combine

extension CustomARView {
    func loadUsdz(file: String, worldAnchor: AnchorEntity) {
        let entity = try! ModelEntity.load(named: file)
        
        let models = (entity.addPhysicsToChildren())
        
        worldAnchor.position = simd_make_float3(0, -10, -8)
        worldAnchor.addChild(entity)
        
        self.scene.anchors.append(worldAnchor)
    }
    
    func loadBall(physicalSphere: ModelEntity) {
        ballWorldAnchor.position = simd_make_float3(4.5, -7, -11)
        
        physicalSphere.physicsBody = PhysicsBodyComponent(massProperties: PhysicsMassProperties(shape: .generateSphere(radius: 0.2), mass: 100.0) ,
                                                          material: .generate(),
                                                          mode: .dynamic)
        physicalSphere.generateCollisionShapes(recursive: false)
        ballWorldAnchor.addChild(physicalSphere)
        self.scene.anchors.append(ballWorldAnchor)
    }

    func loadBucket() {
        let worldAnchor = AnchorEntity()
        let bucket = try! ModelEntity.load(named: "bucket.usdz")
        let collision = try! ModelEntity.load(named: "collision.usdz")
        collision.addPhysicsToChildren()
        
        worldAnchor.position = simd_make_float3(-7.5, -16, -8)
        worldAnchor.addChild(collision)
        worldAnchor.addChild(bucket)

        self.scene.anchors.append(worldAnchor)
    }
}
