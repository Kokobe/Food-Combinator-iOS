//
//  IngredientSelectorView.swift
//  Food Combinator
//
//  Created by Kobe Chang on 3/25/21.
//

import SwiftUI

struct IngredientSelectorView: View {
    @State var fridge:[Ingredient] = []
    var ingredients: [Ingredient] = []
    
    var body: some View {
        VStack {
            FridgeView(fridge: $fridge)
            
            IngredientsView(ingredients: ingredients)
            
            
            Button(action: {}) {
                Text("What can I make?")
            }
            Spacer()
                .frame(height: 27.0)
        }
        
    }
}

struct IngredientSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientSelectorView(fridge: testFridgeData, ingredients: testIngredientsData)
    }
}

struct FridgeItemCell: View {
    let ingredient: Ingredient
    
    var body: some View {
        HStack {
            Image(systemName: "photo")
            VStack(alignment: .leading) {
                Text(ingredient.name)
                Text("Count: \(ingredient.count)")
                    .foregroundColor(Color.gray)
            }
            Spacer()
            Button(action: {
                
            }) {
                Image(systemName: "trash")
            }
        }
    }
}

struct FridgeView: View {
    @Binding var fridge: [Ingredient]
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(fridge) { ingredient in
                    FridgeItemCell(ingredient: ingredient)
                }.onDelete(perform: delete)
            }.navigationBarTitle(Text("Fridge"))
        }
        .frame(height: 300.0)
        
    }
    func delete(at offsets: IndexSet) {
        fridge.remove(atOffsets: offsets)
    }
}

struct IngredientsView: View {
    @State var ingredientSearchText: String = ""
    
    let ingredients: [Ingredient]
    
    var body: some View {
        VStack {
            HStack {
                Text("Ingredients")
                    .font(.title)
                    .fontWeight(.bold)
                    
                Spacer()
                    .frame(width: 110.0)
                Button(action: {}) {
                    Text("Speech to Text")
                }
            }
            .padding(.top, 50.0)
            
            List {
                TextField("Search For Ingredient", text: $ingredientSearchText )
                
                ForEach(ingredients) { ingredient in
                    HStack {
                        Image(systemName: "photo")
                        Text(ingredient.name)
                    }
                }
            }
            
        }
        
        
    }
    
}
