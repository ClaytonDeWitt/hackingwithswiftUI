//
//  ContentView.swift
//  BetterRest
//
//  Created by Clay on 12/6/21.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var idealTimeToSleep = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .background(Color.white).edgesIgnoringSafeArea(.all)
                        
                    
                }
                
                
                Section(header: Text("Desired amount of sleep")) {
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section(header: Text("Daily coffee intake")) {
                    
                    //                            Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                    
                    Picker("Daily coffee intake", selection: $coffeeAmount) {
                        ForEach(1..<21) { coffeeAmount in
                            if coffeeAmount == 1 {
                                Text("1 cup")
                            } else {
                                Text("\(coffeeAmount) cups")
                                
                            }
                        }
                    }
                    
                }
                
                
                Section(header: Text("Your ideal bedtime")) {
                    Text(idealTimeToSleep)
                        .font(.largeTitle)
                }
            }
            
            
            .navigationBarTitle("BetterRest")
            .onAppear {
                calculateBedtime()
                UITableView.appearance().backgroundColor = .systemCyan
            }
            .onChange(of: wakeUp) { _ in
                calculateBedtime()
            }
            .onChange(of: sleepAmount) { _ in
                calculateBedtime()
            }
            .onChange(of: coffeeAmount) { _ in
                calculateBedtime()
            }
        }
    }
    


    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
           
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            idealTimeToSleep = formatter.string(from: sleepTime)
            
            
        } catch {
            
            idealTimeToSleep = "Sorry, there was a problem calculating your bedtime."
        }
        
        showingAlert = true
    }
}
        

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
