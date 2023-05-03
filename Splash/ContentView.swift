import SwiftUI

struct ContentView: View {
    @State var arView: CustomARViewRepresentable
    let joystick = VirtualJoystick()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let timerColor = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    let height = UIScreen.main.bounds.height
    @ObservedObject var gameRounds = GameLogic()
    
        
    init(isShowingAR: Bool = false, gameRounds: GameLogic = GameLogic()) {
        self.gameRounds = gameRounds
        self.arView = CustomARViewRepresentable(customArView: CustomARView(gameRounds: gameRounds))
    }
    
    var body: some View {
        arView.ignoresSafeArea()
            .overlay (
                ZStack {
                    ZStack {}
                        .ignoresSafeArea()
                        .frame(width: UIScreen.main.bounds.width, height: height)
                        .background(.black)
                        .opacity(gameRounds.screen == .game ? 0 : 0.6)
                    
                    routes
                    
                }
                    .onReceive(timer) { _ in
                        ARManager.shared.actionStream.send(.updateBall)
                    }
                
                    .onReceive(timerColor) { _ in
                        ARManager.shared.actionStream.send(.changeBallColor)
                    }
            )
    }
    
    
    @ViewBuilder var routes: some View {
        if gameRounds.screen == .home {
            home
        } else if gameRounds.screen == .game {
            game
        } else if gameRounds.screen == .credits {
            credits
        } else if gameRounds.screen == .howToPlay1 {
            howToPlay1
        } else if gameRounds.screen == .howToPlay2 {
            howToPlay2
        } else if gameRounds.screen == .howToPlay3 {
            howToPlay3
        } else if gameRounds.screen == .gameWon {
            gameWon
        }
    }
}

