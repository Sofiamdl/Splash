//
//  File.swift
//  
//
//  Created by sml on 11/04/23.
//

import SwiftUI

enum ARAction {
    case rotate(offset: CGSize)
    case transform(offset: CGSize)
    case play
    case updateBall
    case changeBallColor
}
