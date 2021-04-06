//
//  RecipesView.swift
//  Food Combinator
//
//  Created by Kobe Chang on 3/29/21.
//

import SwiftUI

struct RecipesView: View {
    @EnvironmentObject var recipeService: RecipeWebService
    @State var loading = true
    var body: some View {
        if (recipeService.loading) {
            
            VStack {
                Text("Searching the web for Recipes...")
                    .font(.title3)
                    .fontWeight(.light)
                Spacer()
                    .frame(height: 40.0)
                ActivityIndicator(shouldAnimate: $loading)
                
                
                
            } .navigationBarTitle(Text("Recipes"), displayMode: .inline)
            .navigationBarColor(.systemGreen)
        }
        else {
            List {
                ForEach (recipeService.recipes_pub) { recipe in
                    RecipeItemCell(recipe:recipe).frame(height: 500)
                }
            }.navigationBarTitle(Text("Recipes"), displayMode: .inline)
            .navigationBarColor(.systemGreen)
        }
        
    }
    
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        let recipeService = RecipeWebService(testDataEnabled: true)
        RecipesView().environmentObject(recipeService)
    }
}

struct RecipeItemCell: View {
    let recipe: Recipe
    
    var body: some View {
        VStack {
            Text(recipe.title ?? "none")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
                .padding(0.0)
                .frame(height: 9.0)
            
            
            ImageView(withURL: recipe.image ?? "no image")
            
            List {
                ForEach (recipe.ingredients) { ingredient in
                    Text(ingredient.name)
                }
            }
        }
    }
}
