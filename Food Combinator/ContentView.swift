//
//  ContentView.swift
//  Food Combinator
//
//  Created by Kobe Chang on 3/19/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    @State var userBullseye: Double = 50
    
    var body: some View {
        VStack {
            // Target Row
            HStack {
                Text("Put the bullseye as close as you can to: ")
                
                Text("100")
            }
            
            // Slider Row
            HStack {
                Text("1")
                Slider(value: $userBullseye)
                    .frame(width: 300.0)
                Text("100")
            }
            

            Button(action: {
                print("button pressed!")
                self.alertIsVisible = true
            }) {
                Text("Hit me")
            }
            .alert(isPresented: $alertIsVisible) { () ->
                Alert in
                return Alert(title: Text("Nice!"), message: Text("You scored a 100."),
                    dismissButton: .default(Text("Next Round")))
            }
            
            
            // Score Info Row
            HStack {
                Button(action: {}) {
                    Text("Start Over")
                }
                Text("Score: ")
                Text("999999")
                Text("Round: ")
                Text("99999")
                Button(action: {}) {
                    Text("Info")
                }
            }
        
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
