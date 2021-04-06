//
//  Food_CombinatorApp.swift
//  Food Combinator
//
//  Created by Kobe Chang on 3/19/21.
//

import SwiftUI

@main
struct Food_CombinatorApp: App {
    @StateObject var recipeService = RecipeWebService()
    
    var body: some Scene {
        WindowGroup {
            IngredientSelectorView(fridge: testFridgeData, ingredients: testIngredientsData)
                .environmentObject(recipeService)
        }
    }
}
