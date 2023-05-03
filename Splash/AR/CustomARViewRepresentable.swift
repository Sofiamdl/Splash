//
//  File.swift
//  
//
//  Created by sml on 10/04/23.
//

import SwiftUI

struct CustomARViewRepresentable: UIViewRepresentable {
    let customArView: CustomARView
    
    init(customArView: CustomARView) {
        self.customArView = customArView
    }

    func makeUIView(context: Context) -> CustomARView {
        return customArView
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {       
    }
    
}
