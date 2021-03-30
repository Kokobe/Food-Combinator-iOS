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
        NavigationView {
            
            VStack {
                Section {
                    FridgeView(fridge: $fridge)
                    IngredientsView(ingredients: ingredients, fridge: $fridge)
                }
               
                NavigationLink(destination: RecipesView(fridge: fridge)) {
                        Text("What can I make?")
                }
                
                
                
            }.navigationTitle("Select Ingredients")
            .navigationBarColor(.systemBlue)
            .animation(.spring())
            .listStyle(GroupedListStyle())
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct FridgeView: View {
    @Binding var fridge: [Ingredient]
    
    var body: some View {
        
        
        List {
            Text("Fridge")
                .font(.title)
                .fontWeight(.bold)
            ForEach(fridge) { ingredient in
                FridgeItemCell(ingredient: ingredient)
            }.onDelete(perform: delete)
        }
        
        
    }
    func delete(at offsets: IndexSet) {
        fridge.remove(atOffsets: offsets)
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
            Button(action: {}) {
                Image(systemName: "trash")
            }
        }
    }
}


struct IngredientsView: View {
    @State var ingredientSearchText: String = ""
    
    let ingredients: [Ingredient]
    @Binding var fridge: [Ingredient]
    
    var body: some View {
        List {
            HStack {
                Text("Ingredients")
                    .font(.title)
                    .fontWeight(.bold)
                
//                Spacer()
//                    .frame(width: 110.0)
//                Button(action: {}) {
//                    Image(systemName: "heart.fill")
//                }
            }
            TextField("Search For Ingredient", text: $ingredientSearchText )
            
            ForEach(ingredients) { ingredient in
                Button(action: {
                    addIngredient(ingredient: ingredient)
                }) {
                    HStack {
                        Image(systemName: "photo")
                        Text(ingredient.name)
                    }.accentColor(.black)
                }
            }
        }
    }
    
    func addIngredient(ingredient: Ingredient) {
        if let index = fridge.firstIndex(where: { $0.name == ingredient.name}) {
            fridge[index].count += 1
        }
        else {
            fridge.insert(ingredient, at: 0)
            print(fridge[0])
        }
        
    }
}

struct IngredientSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientSelectorView(fridge: testFridgeData, ingredients: testIngredientsData)
        
        IngredientSelectorView(fridge: testFridgeData, ingredients: testIngredientsData).preferredColorScheme(.dark)
    }
}


extension View {
    
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
    
}
