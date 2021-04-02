//
//  ContentView.swift
//  Food Combinator
//
//  Created by Kobe Chang on 3/19/21.
//

import SwiftUI

func generateNewTarget() ->  Int {
    return Int.random(in: 1..<100)
}

struct ContentView: View {
    
    /// when these vars are updated, the UI will refresh to keep it consistent
    @State private var alertIsVisible: Bool = false
    @State private var sliderValue: Double = 50.9999
    @State private var target: Int = generateNewTarget()
    @State private var totalPoints = 0
    @State private var round = 1
    
    var body: some View {
        
        VStack {
            Spacer()
            
            // Target Row
            HStack {
                Text("Put the bullseye as close as you can to: ")
                
                Text("100")
            }
            
            Spacer()
            
            Text("test: \(sliderValueRounded()), target: \(target)")
            
            // Slider Row
            HStack {
                Text("1")
                Slider(value: $sliderValue, in: 1...100)
                    .frame(width: 300.0)
                Text("100")
            }
            
            Spacer()
            
            // calculate score button
            Button(action: {
                alertIsVisible = true
                //getWebscrapeData()
            }) {
                Text("Hit me")
            }
            .alert(isPresented: $alertIsVisible) { () ->
                Alert in

                return Alert(title: Text(alertTitle()), message: Text("The slider's value is \(sliderValueRounded()).\n"
                + "You scored \(pointsForCurrentRound()) points in this round"),
                             dismissButton: .default(Text("Next Round")) {
                                
                                self.totalPoints += self.pointsForCurrentRound()
                                target = generateNewTarget()
                                round += 1
                             }
                )
            }
            
            Spacer()
            
            // Score Info Row
            HStack {
                Button(action: {
                    resetEverything()
                }) {
                    Text("Start Over")
                }
                Text("Score: ")
                Text("\(totalPoints)")
                Text("Round: ")
                Text("\(round)")
                Button(action: {}) {
                    Text("Info")
                }
            }.padding(.bottom, 20)
            
        }
    }
    
    func resetEverything() {
        totalPoints = 0
        round = 1
    }
    
    func sliderValueRounded() -> Int {
        return Int(sliderValue.rounded())
    }
    
    func pointsForCurrentRound() -> Int {
        return 100 - abs(target - sliderValueRounded())
    }
    
    func alertTitle() -> String {
        let currentPoints = pointsForCurrentRound()
        
        if (currentPoints == 100) {
            return "Perfect!"
        }
        else if currentPoints > 50 {
            return "Almost there!"
        }
        else {
            return "bro not even close..."
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
