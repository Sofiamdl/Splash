//
//  File.swift
//  
//
//  Created by sml on 18/04/23.
//

import SwiftUI

struct PaintBackground<C: View> : View {
    let image: String
    let backFunc: () -> ()
    let nextFunc: () -> ()
    let isCredits: Bool
    let height = UIScreen.main.bounds.height
    typealias Children = C
    typealias NewChildren = () -> (Children)
    
    let childView: Children
    
    init(_ childView: NewChildren, image: String, backFunc: @escaping ()->(), nextFunc: @escaping ()->(), isCredits: Bool) {
        self.image = image
        self.childView = childView()
        self.backFunc = backFunc
        self.nextFunc = nextFunc
        self.isCredits = isCredits
    }
    
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: height * 0.9)
            VStack {
                childView
                    .frame(height: height * 0.9)
                HStack {
                    Button(action:{
                        backFunc()
                    }){
                        ZStack {
                            Image("back-Button")
                                .resizable()
                                .scaledToFit()
                                .frame(height: height * 0.15)
                            Text("back")
                                .font(.custom(.dripOctober, size: height*0.05))
                                .foregroundColor(.white)
                        }
                        .offset(y: -height*0.05)
                        .padding(.leading, 20)
                    }
                    Spacer()
                    if !isCredits{
                        Button(action:{
                            nextFunc()
                        }){
                            ZStack {
                                Image("next-button")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: height*0.15)
                                Text(image == "background-yellow" ? "play": "next")
                                    .font(.custom(.dripOctober, size: height*0.05))
                                    .foregroundColor(.white)
                            }
                            .offset(y: -height*0.05)
                            .padding(.trailing, 20)

                        }
                        
                    }
                    
                }
            }
        }
    }
    
}
