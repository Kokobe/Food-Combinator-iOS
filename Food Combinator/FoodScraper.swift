//
//  FoodScraper.swift
//  Food Combinator
//
//  Created by Kobe Chang on 3/25/21.
//

import Foundation
import Alamofire

func getWebscrapeData() {
    let parameters: [String: Any] = ["ingredients": ["egg", "bread"]]
    
    /*
     To test it the post request in terminal:
     
     curl -i -X POST -H 'Content-Type: application/json' -d '{"ingredients": ["egg", "bread"]}' https://us-central1-food-combinator-308402.cloudfunctions.net/webscrape
     
     */
    
    AF.request("https://us-central1-food-combinator-308402.cloudfunctions.net/webscrape", method: .post, parameters: parameters, encoding: JSONEncoding.default)
        .validate(statusCode: 200..<600)
        .responseJSON { response in
            if let responseJSON = response.value as? [String: AnyObject] {
                
                if let recipes = responseJSON["recipes"] as? [[String: AnyObject]] {
                    
                    for i in 0..<recipes.count {
                        let recipe = recipes[i]
                        let title = recipe["title"] as? String
                        let link = recipe["link"]  as? String
                        let ingredients = recipe["ingredients"] as? [String]
                        
                        print("link: \(link ?? "no link")")
                        print("title: \(title ?? "no title")")
                        print("ingredients: \(ingredients ?? [])")
                        print(responseJSON)
                    }
                }
                
            }
        }
}
