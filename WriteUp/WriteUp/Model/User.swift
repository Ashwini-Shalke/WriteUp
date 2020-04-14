//
//  User.swift
//  WriteUp
//
//  Created by Ashwini shalke on 14/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import Foundation
import AuthenticationServices

struct User {
    let id : String
    let firstname : String
    let lastname : String
    let email : String
    
    init(credentials: ASAuthorizationAppleIDCredential) {
        self.id = credentials.user
        self.firstname = credentials.fullName?.givenName ?? ""
        self.lastname = credentials.fullName?.familyName ?? ""
        self.email = credentials.email ?? ""
    }
}


extension User: CustomDebugStringConvertible {
    var debugDescription: String {
        return """
        ID: \(id)
        First Name: \(firstname)
        Last Name: \(lastname)
        Email: \(email)
        """
    }
}
