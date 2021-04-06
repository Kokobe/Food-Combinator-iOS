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
    @Published var loading: Bool = true { didSet {didChange.send()} }
    
    init(testDataEnabled: Bool = false) {
        //self.fetchRecipes(fridge: fridge)
        if testDataEnabled {
            self.recipes_pub.append(Recipe(title: "Avocados and Toast", ingredients:  translateIngredients(ingredientStringArray:["1 Avocado", "1 Toast"]), link: "https://www.allrecipes.com/recipe/279650/avocado-toast-and-egg-for-one/", image: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F7897357.jpg"))
            
            self.recipes_pub.append(Recipe(title: "Spinach and Feta Turkey Burgers", ingredients: translateIngredients(ingredientStringArray:["2 eggs, beaten", "2 cloves garlic, minced", "4 ounces feta cheese", "1 (10 ounce) box frozen chopped spinach, thawed and squeezed dry", "2 pounds ground turkey"]), link: "https://www.allrecipes.com/recipe/158968/spinach-and-feta-turkey-burgers/", image: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F43%2F2020%2F03%2F20%2F1360550.jpg"))
            
            self.recipes_pub.append(Recipe(title: "Scott Hibb's Amazing Whisky Grilled Baby Back Ribs", ingredients:  translateIngredients(ingredientStringArray: ["2 (2 pound) slabs baby back pork ribs", "coarsely ground black pepper", "1 tablespoon ground red chile pepper", "2 ¼ tablespoons vegetable oil", "½ cup minced onion", "1 ½ cups water", "½ cup tomato paste", "½ cup white vinegar", "½ cup brown sugar", "2 ½ tablespoons honey", "2 tablespoons Worcestershire sauce", "2 teaspoons salt", "¼ teaspoon coarsely ground black pepper", "1 ¼ teaspoons liquid smoke flavoring", "2 teaspoons whiskey", "2 teaspoons garlic powder", "¼ teaspoon paprika", "½ teaspoon onion powder", "1 tablespoon dark molasses", "½ tablespoon ground red chile pepper"]) , link: "https://www.allrecipes.com/recipe/35753/scott-hibbs-amazing-whisky-grilled-baby-back-ribs/", image: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F417609.jpg"))
        }
        
    }
    
    
    
    func fetchRecipes(fridge: [Ingredient]) {
        recipes_pub = []
        
        var ingredients = [String]()
        for i in fridge {
            ingredients.append(i.name)
        }
        
        let parameters: [String: Any] = ["ingredients": ingredients]
        self.loading = true
        
        /*
         To test it the post request in terminal:
         
         curl -i -X POST -H 'Content-Type: application/json' -d '{"ingredients": ["Egg", "bread"]}' https://us-central1-food-combinator-308402.cloudfunctions.net/webscrape
         
         */
        
        AF.request(baseUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                
                if let responseJSON = response.value as? [String: Any] {
                    
                    if let recipes = responseJSON["recipes"] as? [[String: Any]] {
                        
                        self.recipes_pub = []
                        
                        for i in 0..<recipes.count {
                            let recipe = recipes[i]
                            let title = recipe["title"] as? String
                            let image = recipe["image"] as? String
                            let link = recipe["link"]  as? String
                            let ingredients = recipe["ingredients"] as? [String]
                            
                            print("link: \(link ?? "no link")")
                            print("title: \(title ?? "no title")")
                            print("ingredients: \(ingredients ?? [])")
                            
                            let recipe_obj = Recipe(title: title, ingredients: translateIngredients(ingredientStringArray: ingredients ?? ["ingredients not found"]), link: link, image: image)
                            self.recipes_pub.append(recipe_obj)
                            
                        }
                        
                        self.loading = false
                        
                       
                    }
                    
                }
            }
 
    }
    
}


