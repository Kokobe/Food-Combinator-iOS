//
//  Ingredient.swift
//  Food Combinator
//
//  Created by Kobe Chang on 3/25/21.
//

import Foundation

struct Ingredient:Identifiable {
    var id = UUID()
    var name: String
    var count: Int
    
    var imageName: String { return name }
}

#if DEBUG
let testFridgeData = [
    Ingredient(name: "Egg", count: 6),
    Ingredient(name: "Apple", count: 2),
    Ingredient(name: "Bread Slice", count: 12),
    Ingredient(name: "Peanut Butter", count: 1),
    Ingredient(name: "Honey", count: 1)
]

let testIngredientsData = [
    Ingredient(name: "Soy Sauce", count: 1),
    Ingredient(name: "Egg", count: 1),
    Ingredient(name: "Apple", count: 1),
    Ingredient(name: "Bread Slice", count: 1),
    Ingredient(name: "Peanut Butter", count: 1)
]
#endif
