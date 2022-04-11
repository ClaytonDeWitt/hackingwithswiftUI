//
//  ContentView.swift
//  Challenge3
//
//  Created by Clay on 12/21/21.
//

import SwiftUI


struct ContentView: View {
    
    
    @State var multiples = 2
    @State var questions = 5
    
    @State var showingGame = false
    
    var body: some View {
        NavigationView {
            Form{
                Section{
                    VStack{
                        Text("Which multiplication table?")
                        Stepper("\(multiples)", value: $multiples, in: 2...12)
                    }
                }
                Section{
                    VStack{
                        Text("How many questions would you like?")
                        Stepper("\(questions)", value: $questions, in: 5...20, step: 5)
                    }
                }
                Section{
                    VStack{
                        Button("Let's play!") {
                            showingGame.toggle()
                        }
                        .sheet(isPresented: $showingGame) {
                            GameView()
                        }
                        
                    }
                }
                .navigationTitle("Multiplier")
            }
        }
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
