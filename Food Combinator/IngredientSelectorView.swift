//
//  IngredientSelectorView.swift
//  Food Combinator
//
//  Created by Kobe Chang on 3/25/21.
//

import SwiftUI

struct IngredientSelectorView: View {
    var inventory: [Ingredient] = []
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Fridge")
                    .font(.title)
                    .fontWeight(.bold)
                List (inventory) { ingredient in
                    HStack {
                        Image(systemName: "photo")
                        VStack(alignment: .leading) {
                            Text(ingredient.name)
                            Text("Count: \(ingredient.count)")
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
                        Image(systemName: "trash")
                    }
                }
                
                
                HStack {
                    Text("Ingredients")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                        .frame(width: 100.0, height: 4.0)
                    Button(action: {}) {
                        Text("Speech to Text")
                    }
                }
                TextField("Search For Ingredient", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                
                List (0..<5) { item in
                    HStack {
                        Image(systemName: "photo")
                        Text("Ingredient Name")
                    }
                }
                
                
            }
            .padding(.leading, 16.0)
            
            Button(action: {}) {
                Text("What can I make?")
            }
        }
        
    }
}

struct IngredientSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientSelectorView(inventory: testInventoryData)
    }
}
