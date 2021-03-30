//
//  RecipesView.swift
//  Food Combinator
//
//  Created by Kobe Chang on 3/29/21.
//

import SwiftUI

struct RecipesView: View {
    var fridge: [Ingredient]
    
    var body: some View {
        
        List {
            ForEach (fridge) { ingredient in
                Text(ingredient.name)
            }
            
        }
        .navigationBarTitle(Text("Recipes"), displayMode: .inline)
        .navigationBarColor(.systemGreen)
    }
    
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView(fridge: testFridgeData)
    }
}
