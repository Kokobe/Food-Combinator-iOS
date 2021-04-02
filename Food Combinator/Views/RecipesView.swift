//
//  RecipesView.swift
//  Food Combinator
//
//  Created by Kobe Chang on 3/29/21.
//

import SwiftUI

struct RecipesView: View {
    @EnvironmentObject var recipeService: RecipeWebService
    var body: some View {
        
        List {
            ForEach (recipeService.recipes_pub) { recipe in
                Text(recipe.title ?? "none")
            }
            
        }
        .navigationBarTitle(Text("Recipes"), displayMode: .inline)
        .navigationBarColor(.systemGreen)
    }
    
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
