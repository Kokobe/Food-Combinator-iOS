//
//  ContentView.swift
//  Food Combinator
//
//  Created by Kobe Chang on 3/19/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    
    var body: some View {
        VStack {
            Text("Knock Knock")
                .font(.headline)
                .foregroundColor(Color.green)
                .padding()
            
            Button(action: {
                print("button pressed!")
                self.alertIsVisible = true
            }) {
                Text("Who's there?")
            }
            .alert(isPresented: $alertIsVisible) { () ->
                Alert in
                return Alert(title: Text("hey bitch"), message: Text("Hey bitch who?"),
                    dismissButton: .default(Text("Hey bitch I fucked your mom")))
            }
        
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
