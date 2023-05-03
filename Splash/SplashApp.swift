//
//  SplashApp.swift
//  Splash
//
//  Created by sml on 02/05/23.
//

import SwiftUI

@main
struct SplashApp: App {
    
    init() {
        CustomFonts.register()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
