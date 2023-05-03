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
    func transformEntity(worldAnchor: AnchorEntity, offset: CGSize)
    {
        var offsetAux = offset
        if worldAnchor.orientation.imag.z > 0.1 {
            if offsetAux.width < 0 {
                offsetAux.width = 0
            }
        } else if worldAnchor.orientation.imag.z < -0.1 {
            if offsetAux.width > 0 {
                offsetAux.width = 0
            }
        }

        if worldAnchor.orientation.imag.x > 0.1 {
            if offsetAux.height > 0 {
                offsetAux.height = 0
            }
        } else if worldAnchor.orientation.imag.x < -0.1 {
            if offsetAux.height < 0 {
                offsetAux.height = 0
            }
        }
 

        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let rotationRoll:Float = -Float(offsetAux.width / 720)
            let rotationPitch:Float = Float(offsetAux.height  / 720)
            let transform = Transform(pitch: rotationPitch, yaw: 0, roll: rotationRoll)
            worldAnchor.move(to: transform,
                        relativeTo: worldAnchor,
                             duration: 0.4)
        }
    }
    
    func transformEntityWhenChange(worldAnchor: AnchorEntity)
    {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let rotationRoll:Float = -worldAnchor.orientation.imag.z
            let rotationPitch:Float = -worldAnchor.orientation.imag.x
            let rotationYall:Float = -worldAnchor.orientation.imag.y
            let transform = Transform(pitch: rotationPitch, yaw: rotationYall, roll: rotationRoll)
            worldAnchor.move(to: transform,
                        relativeTo: worldAnchor,
                             duration: 0.2)
        }
    }
}
