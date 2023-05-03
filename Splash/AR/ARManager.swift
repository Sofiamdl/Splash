//
//  File.swift
//  
//
//  Created by sml on 11/04/23.
//

import Combine

class ARManager {
    static let shared = ARManager()
    private init() {}
    
    var actionStream = PassthroughSubject<ARAction, Never>()
}
