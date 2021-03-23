//
//  ContentView.swift
//  Food Combinator
//
//  Created by Kobe Chang on 3/19/21.
//

import SwiftUI
import Alamofire

func generateNewTarget() ->  Int {
    return Int.random(in: 1..<100)
}

func getWebscrapeData() {
    // prepare json data
    /*
    let json: [String: Any] = ["message": "hello dude",
                               "dict": ["1":"First", "2":"Second"]]
     */
    
   
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
        /*
        .responseString { response in
            
            switch response.result {
                case .success:
                    print("Validation Successful")
                    ///debugPrint(response)
                    //print(String(response.value ?? "novalue"))
                    let strJSON = String(response.value ?? "novalue")
                    let data = Data(strJSON.utf8)
                    
                    print(strJSON)
                    do {
                        
                        // make sure this JSON is in the format we expect
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            // try to read out a string array
                            let recipes = json["recipes"] as? [Any]
                            for recipe in recipes ?? [] {
                                let recipeJSON = recipe as? [String: Any]
                                print(recipeJSON?["title"] as? String ?? "no name")
                                print(recipeJSON?["ingredients"] as? [String] ?? "no ingredients")
                            }
                        }
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                case let .failure(error):
                    print(error)
                }
        }
        */
}

struct ContentView: View {
    
    /// when these vars are updated, the UI will refresh to keep it consistent
    @State private var alertIsVisible: Bool = false
    @State private var sliderValue: Double = 50.9999
    @State private var target: Int = generateNewTarget()
    @State private var totalPoints = 0
    @State private var round = 1
    
    var body: some View {
        
        VStack {
            Spacer()
            
            // Target Row
            HStack {
                Text("Put the bullseye as close as you can to: ")
                
                Text("100")
            }
            
            Spacer()
            
            Text("test: \(sliderValueRounded()), target: \(target)")
            
            // Slider Row
            HStack {
                Text("1")
                Slider(value: $sliderValue, in: 1...100)
                    .frame(width: 300.0)
                Text("100")
            }
            
            Spacer()
            
            // calculate score button
            Button(action: {
                alertIsVisible = true
                getWebscrapeData()
            }) {
                Text("Hit me")
            }
            .alert(isPresented: $alertIsVisible) { () ->
                Alert in

                return Alert(title: Text(alertTitle()), message: Text("The slider's value is \(sliderValueRounded()).\n"
                + "You scored \(pointsForCurrentRound()) points in this round"),
                             dismissButton: .default(Text("Next Round")) {
                                
                                self.totalPoints += self.pointsForCurrentRound()
                                target = generateNewTarget()
                                round += 1
                             }
                )
            }
            
            Spacer()
            
            // Score Info Row
            HStack {
                Button(action: {
                    resetEverything()
                }) {
                    Text("Start Over")
                }
                Text("Score: ")
                Text("\(totalPoints)")
                Text("Round: ")
                Text("\(round)")
                Button(action: {}) {
                    Text("Info")
                }
            }.padding(.bottom, 20)
            
        }
    }
    
    func resetEverything() {
        totalPoints = 0
        round = 1
    }
    
    func sliderValueRounded() -> Int {
        return Int(sliderValue.rounded())
    }
    
    func pointsForCurrentRound() -> Int {
        return 100 - abs(target - sliderValueRounded())
    }
    
    func alertTitle() -> String {
        let currentPoints = pointsForCurrentRound()
        
        if (currentPoints == 100) {
            return "Perfect!"
        }
        else if currentPoints > 50 {
            return "Almost there!"
        }
        else {
            return "bro not even close..."
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
