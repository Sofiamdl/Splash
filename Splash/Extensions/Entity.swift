//
//  File.swift
//  
//
//  Created by sml on 11/04/23.
//

import RealityKit

extension Entity {
    func addPhysicsToChildren() -> [ModelEntity] {
        if let modelEntity = self as? ModelEntity {
            if modelEntity.name == "Mesh" {
                modelEntity.physicsBody = PhysicsBodyComponent(massProperties: .default, // mass
                                                               material: .generate(friction: 0.1, // Coefficient of friction
                                                                                   restitution: 0.1), // Conservation rate of kinetic energy of collision
                                                               mode: .kinematic)
                // Attach a physical body in .kinematic mode
                modelEntity.generateCollisionShapes(recursive: false)
            }
            return [modelEntity]
        } else {
            var aux: [ModelEntity] = []
            for x in (self.children) {
                let foundChildren = x.addPhysicsToChildren()
                aux.append(contentsOf: foundChildren)
            }
            return aux
        }
    }
}
