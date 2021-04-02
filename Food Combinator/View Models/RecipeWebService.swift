//
//  RecipeViewModel.swift
//  Food Combinator
//
//  Created by Kobe Chang on 4/1/21.
//

import Foundation
import Combine
import Alamofire

class RecipeWebService: ObservableObject {
    private let baseUrl: String = "https://us-central1-food-combinator-308402.cloudfunctions.net/webscrape"
    private var task: Cancellable? = nil
    
    //didChange = sending a message to anyone watching us -> we want to just say a change happened + never throw errors
    var didChange = PassthroughSubject<Void, Never>()
    
    // send a notification whenever this property changes
    @Published var recipes_pub: [Recipe] = [] { didSet {didChange.send()} }
    
    init() {
        //self.fetchRecipes(fridge: fridge)
    }
    
    func fetchRecipes(fridge: [Ingredient]) {
        
        
        var ingredients = [String]()
        for i in fridge {
            ingredients.append(i.name)
        }
        
        let parameters: [String: Any] = ["ingredients": ingredients]
        
        /*
         To test it the post request in terminal:
         
         curl -i -X POST -H 'Content-Type: application/json' -d '{"ingredients": ["Egg", "bread"]}' https://us-central1-food-combinator-308402.cloudfunctions.net/webscrape
         
         */
        
        AF.request(baseUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                
                if let responseJSON = response.value as? [String: Any] {
                    
                    if let recipes = responseJSON["recipes"] as? [[String: Any]] {
                        
                        
                        for i in 0..<recipes.count {
                            let recipe = recipes[i]
                            let title = recipe["title"] as? String
                            let image = recipe["image"] as? String
                            let link = recipe["link"]  as? String
                            let ingredients = recipe["ingredients"] as? [String]
                            
                            print("link: \(link ?? "no link")")
                            print("title: \(title ?? "no title")")
                            print("ingredients: \(ingredients ?? [])")
                            
                            let recipe_obj = Recipe(title: title, ingredients: ingredients ?? ["ingredients not found"], link: link, image: image)
                            self.recipes_pub.append(recipe_obj)
                            
                        }
                        
                       
                    }
                    
                }
            }
 
    }
    
}


