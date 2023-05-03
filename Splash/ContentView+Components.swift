//
//  File.swift
//  
//
//  Created by sml on 18/04/23.
//

import SwiftUI

extension ContentView {
    var game: some View {
        VStack {
            HStack {
                Text("Add the color \(gameRounds.getCurrentLevelString()) to the bucket")
                    .font(.custom(.dripOctober, size: height*0.05))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2)
                Image(gameRounds.getCurrentLevelString())
                    .resizable()
                    .scaledToFit()
                    .frame(height: height*0.16)
            }.padding(.top, 30)
            Spacer()
            HStack {
                Spacer()
                joystick
                    .padding(.bottom, 40)
                    .padding(.trailing, 50)
            }
        }
    }
    
    var home: some View {
        VStack {
            Button(action:{
                gameRounds.screen = .game
                ARManager.shared.actionStream.send(.play)
            }){
                Image("play")
                    .resizable()
                    .scaledToFit()
                    .frame(height: height*0.7)
            }
            HStack {
                Button(action:{
                    gameRounds.screen = .credits
                }){
                    ZStack {
                        Image("credits-button")
                            .resizable()
                            .scaledToFit()
                            .frame(height: height*0.14)
                        Text("about")
                            .font(.custom(.dripOctober, size: height*0.05))
                            .foregroundColor(.white)
                    }
                }.padding(.trailing, 20)
                Button(action:{
                    gameRounds.screen = .howToPlay1
                }){
                    ZStack {
                        Image("how-to-play-button")
                            .resizable()
                            .scaledToFit()
                            .frame(height: height*0.14)
                        Text("how to play")
                            .font(.custom(.dripOctober, size: height*0.05))
                            .foregroundColor(.white)
                    }
                }.padding(.leading, 20)
            }
        }
    }
    
    var credits: some View {
        PaintBackground({
            VStack {
                Text("about")
                    .multilineTextAlignment(.center)
                    .font(.custom(.dripOctober, size: height*0.05))
                    .foregroundColor(.white)
                    .padding(.top, height*0.25)
                Text("Splash is a game that helps you develop your artistic and logical side while having fun! Play it to improve your understanding of color mixing and mechanics, so you can finish it faster every time. The game was created using Swift Playgrounds, RealityKit, ARKit, and Combine.")
                    .multilineTextAlignment(.center)
                    .font(.custom(.dripOctober, size: height*0.042))
                    .foregroundColor(.white)
                    .frame(width: height*0.78)
                    .padding(.top, 10)

            }
        }, image: "background-purple",
                        backFunc: {
            gameRounds.screen = .home
        }, nextFunc: {
            print("")
        }, isCredits: true)
    }
    
    var howToPlay1: some View {
        PaintBackground({
            VStack {
                Text("change the color of the ball by getting close to the puddles of paint")
                    .multilineTextAlignment(.center)
                    .font(.custom(.dripOctober, size: height*0.04))
                    .foregroundColor(.white)
                    .frame(width: height*0.9)
                    .padding(.top, height*0.25)
                    

                Image("labyrinth")
                    .resizable()
                    .scaledToFit()
                    .frame(height: height * 0.35)
            }
        }, image: "background-red",
        backFunc: {
            gameRounds.screen = .home
        }, nextFunc: {
            gameRounds.screen = .howToPlay2
        }, isCredits: false)
    }
    
    var howToPlay2: some View {
        PaintBackground({
            VStack {
                Text("put the ball in the bucket to compute the color")
                    .font(.custom(.dripOctober, size: height*0.04))
                    .foregroundColor(.white)
                    .frame(width: height*0.9)
                    .padding(.top, height*0.25)
                
                Image("bucket")
                    .resizable()
                    .scaledToFit()
                    .frame(height: height * 0.35)
            }
        }, image: "background-blue",
                        backFunc: {
            gameRounds.screen = .howToPlay1
        }, nextFunc: {
            gameRounds.screen = .howToPlay3
        }, isCredits: false)
    }
    
    var howToPlay3: some View {
        PaintBackground({
            VStack {
                Text("change the rotation of the labyrinth with the controller")
                    .font(.custom(.dripOctober, size: height*0.04))
                    .foregroundColor(.black)
                    .frame(width: height*0.9)
                    .padding(.top, height*0.15)
                VirtualJoystick()
            }
        }, image: "background-yellow",
        backFunc: {
            gameRounds.screen = .howToPlay2
        }, nextFunc: {
            gameRounds.screen = .game
            ARManager.shared.actionStream.send(.play)
        }, isCredits: false)
    }
    
    var gameWon: some View {
        ZStack {
            Image("wonScreen")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .frame(minWidth:UIScreen.main.bounds.width, minHeight: height)
            VStack{
                Text("congratulations!!!")
                    .font(.custom(.dripOctober, size: height*0.08))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 20)
                Text("you are a true artist")
                    .font(.custom(.dripOctober, size: height*0.08))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 20)
                Button(action:{
                    gameRounds.reset()
                    gameRounds.screen = .game
                }){
                    ZStack {
                        Image("button-brown")
                            .resizable()
                            .scaledToFit()
                            .frame(height: height*0.18)
                        Text("play again")
                            .font(.custom(.dripOctober, size: height*0.05))
                            .foregroundColor(.white)
                    }

                }
            }

        }
    }
}
