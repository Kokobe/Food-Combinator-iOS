//
//  FridgeStore.swift
//  Food Combinator
//
//  Created by Kobe Chang on 3/26/21.
//

import SwiftUI
import Combine

class FridgeStore : ObservableObject {
    var fridge: [Ingredient] {
        didSet {didChange.send()} //notifies subject (the body view) when fridge changes!
    }
    
    init(fridge: [Ingredient] = []) {
        self.fridge = fridge
    }
    
    // gives local object we can subscribe to and send updates to
    var didChange = PassthroughSubject<Void, Never>()
}
