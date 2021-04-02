//
//  Recipe.swift
//  Food Combinator
//
//  Created by Kobe Chang on 4/2/21.
//

import Foundation

struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Decodable, Identifiable {
    var id = UUID()
    let title: String?
    let ingredients: [String?]
    let link: String?
    let image: String?
    
    static var placeholder: Recipe {
        return Recipe(title: "no title", ingredients: ["no ingredients"], link: "no link", image: "no image url")
    }
}
