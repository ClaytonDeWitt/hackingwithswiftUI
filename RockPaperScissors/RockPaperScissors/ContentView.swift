//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Clay on 12/6/21.
//

import SwiftUI

struct ContentView: View {
    
    let game = ["Rock", "Paper", "Scissors"]
    @State private var gameChoice = Int.random(in: 0 ... 2)
    @State private var shouldWin = Bool.random
    @State private var playerScore = 0
    @State private var scoreTitle = ""
    @State private var showingScore = false
    
    var body: some View {
            VStack {
                Text("Player Score: \(playerScore)")
                Text("Computers Move: \(game[gameChoice])")
                Text("You should \(shouldWin() ? "Win" : "Lose")")
                HStack {
                    ForEach(0 ..< game.count) { number in
                        Button(action: {
                            self.buttonTapped(number)
                        }) {
                            Text("\(game[number])")
                                .frame(width: 100, height: 75, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .gameButtons()
                                
                        }
                    }
                }
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("Your score is \(self.playerScore)"), dismissButton: .default(Text("Continue")) {
                    self.restartGame()
                })
            }
    }
    
    func restartGame() {
        gameChoice = Int.random(in: 0...2)
        shouldWin = Bool.random
    }
    
    func buttonTapped(_ number: Int) {
        if shouldWin() {
            // handle when user should win
            switch gameChoice {
            case 0:
                if number == 1 {
                    playerScore += 1
                    scoreTitle = "You win!"
                } else if number == 0 {
                    scoreTitle = "Draw!"
                } else {
                    playerScore -= 1
                    scoreTitle = "You lose!"
                }
            case 1:
                if number == 2 {
                    playerScore += 1
                    scoreTitle = "You win!"
                } else if number == 1 {
                    scoreTitle = "Draw!"
                } else {
                    playerScore -= 1
                    scoreTitle = "You lose!"
                }
            case 2:
                if number == 0 {
                    playerScore += 1
                    scoreTitle = "You win!"
                } else if number == 2 {
                    scoreTitle = "Draw!"
                } else {
                    playerScore -= 1
                    scoreTitle = "You lose!"
                }
            default:
                print("Error")
            }
        } else {
            // handle when they should lose
            switch gameChoice {
            case 0:
                if number == 0 {
                    scoreTitle = "Draw!"
                } else if number == 1 {
                    scoreTitle = "You lose!"
                    playerScore -= 1
                } else {
                    scoreTitle = "You win!"
                    playerScore += 1
                }
            case 1:
                if number == 1 {
                    scoreTitle = "Draw!"
                } else if number == 0 {
                    scoreTitle = "You win!"
                    playerScore += 1
                } else {
                    scoreTitle = "You lose!"
                    playerScore -= 1
                }
            case 2:
                if number == 2 {
                    scoreTitle = "Draw!"
                } else if number == 0 {
                    scoreTitle = "You Lose!"
                    playerScore -= 1
                } else {
                    scoreTitle = "You win!"
                    playerScore += 1
                }
            default:
                print("Error")
            }
        }
        showingScore = true
    }
}

struct GameButtons: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .overlay(Capsule()
                        .stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func gameButtons() -> some View {
        self.modifier(GameButtons())
    }
}
