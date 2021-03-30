//
//  Food_CombinatorApp.swift
//  Food Combinator
//
//  Created by Kobe Chang on 3/19/21.
//

import SwiftUI

@main
struct Food_CombinatorApp: App {
    var body: some Scene {
        WindowGroup {
            IngredientSelectorView(fridgeModel: testFridgeData, ingredients: testIngredientsData)
        }
    }
}
