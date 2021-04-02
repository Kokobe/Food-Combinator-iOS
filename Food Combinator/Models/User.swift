//
//  User.swift
//  Food Combinator
//
//  Created by Kobe Chang on 4/1/21.
//

import UIKit
// SINGLETON

class User {
    static let local = User()
    
    let id = UUID()
    var name: String {UIDevice.current.name} // scott's iphone or something
    
    private init() {} // allows for only 1 instance of this class
}
