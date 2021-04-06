//
//  Recipe.swift
//  Food Combinator
//
//  Created by Kobe Chang on 4/2/21.
//

import Foundation

struct RecipeResponse {
    let recipes: [Recipe]
}

struct Recipe: Identifiable {
    var id = UUID()
    let title: String?
    let ingredients: [Ingredient]
    let link: String?
    let image: String?
    
    static var placeholder: Recipe {
        return Recipe(title: "no title", ingredients: [Ingredient(name: "no ingredients")], link: "no link", image: "no image url")
    }
}
