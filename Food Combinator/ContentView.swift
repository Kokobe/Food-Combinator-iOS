//
//  ContentView.swift
//  Food Combinator
//
//  Created by Kobe Chang on 3/19/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Bro this is a food app")
                .font(.headline)
                .foregroundColor(Color.green)
                .padding()
            Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Button")/*@END_MENU_TOKEN@*/
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
