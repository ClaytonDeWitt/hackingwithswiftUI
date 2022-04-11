//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Clay on 11/29/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var endOfGame = false
    @State private var scoreTitle = ""
    @State private var scoreCount = 0
    @State private var questionCount = 0
    
    @State private var animationAmount = 0.0
    @State private var opacityAmount = 1.0
    
    @State private var countries = ["Estonia", "France", "Ireland", "Germany", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle .bold())
                    .foregroundColor(.white)
                
                VStack (spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0 ..< 3) { number in
                         Button(
                           action: {
                             self.flagTapped(number)
                           },
                           label: {
                             if number == correctAnswer {
                             FlagImage(flagName: self.countries[number])
                               .rotation3DEffect(
                                 .degrees(animationAmount),
                                 axis: (x: 0.0, y: 1.0, z: 0.0)
                               )
                             } else {
                               FlagImage(flagName: self.countries[number])
                                 .opacity(opacityAmount)
                             }
                           }
                         )
                       }
                             
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(scoreCount)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(scoreCount)")
           
           
        }
        .alert("Game Over", isPresented: $endOfGame) {
            Button("Let's go again!", action: reset)
        } message: {
            Text("You've finished! Your final score is \(scoreCount)")

                
        }
    
    
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreCount += 1
            withAnimation {
                self.animationAmount += 360
                opacityAmount = 0.25
            }
        } else {
            scoreTitle = "Wrong, that's the flag of \(countries[number])"
            scoreCount -= 1
            withAnimation {
                
            }
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCount += 1
        animationAmount = 0
        opacityAmount = 1
        
        if questionCount >= 8 {
            endOfGame = true
            
            }
        }
    
    func reset() {
        scoreCount = 0
        scoreTitle = ""
        questionCount = 0
    
            
        }
    }
    


struct FlagImage: View {
    let flagName: String
    
    var body: some View {
        Image(flagName)
            .renderingMode(.original)
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
