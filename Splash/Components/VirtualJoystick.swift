//
//  File.swift
//  
//
//  Created by sml on 11/04/23.
//

import SwiftUI

struct VirtualJoystick: View {
    @State var customOffset: CGSize = CGSize.zero
    let maxRadius = 60.0
    
    var drag: some Gesture {
            DragGesture()
            .onChanged { gesture in
                let width = gesture.translation.width
                let height = gesture.translation.height
                let radius = calculateRadius(a: width, b:height)
                if radius < maxRadius {
                    customOffset = gesture.translation
                } else {
                    customOffset = calculatePlace(radius: radius, width: width, height: height, maxRadius: maxRadius)
                }
                ARManager.shared.actionStream.send(.rotate(offset: customOffset))
            }
            .onEnded { _ in
                customOffset = .zero
            }
        }
    var body: some View {
        ZStack {
            Circle()
                .fill(.black)
                .frame(width: 200, height: 200)
                .opacity(0.5)
                
            Circle()
                .fill(.gray)
                .frame(width: 100, height: 100)
                .offset(customOffset)
                .gesture(drag)

        }
    }
    
    func calculateRadius(a: CGFloat, b: CGFloat) -> CGFloat {
        return sqrt(abs(pow(a,2)) + abs(pow(b,2)))
    }
    
    func calculatePlace(radius: CGFloat, width:CGFloat, height: CGFloat, maxRadius: CGFloat) -> CGSize {
        let finalWidth =  (maxRadius * width)/radius
        let finalHeight =  (maxRadius * height)/radius
        return CGSize(width: finalWidth, height: finalHeight)
        
    }
}
