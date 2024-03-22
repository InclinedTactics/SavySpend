//
//  User.swift
//  SavySpend
//
//  Created by J. DeWeese on 3/21/24.
//

import SwiftUI
import SwiftData

@Model
class User  {
  
    var name: String
     var userName: String
    var userEmail: String
    
    
    init(name: String, userName: String, userEmail: String) {
       
        self.name = name
        self.userName = userName
        self.userEmail = userEmail
       
    }
    static func example() -> User {
        User( name: "John Doe", userName: "johndoe", userEmail: "johndoe@example.com")
    }
}
