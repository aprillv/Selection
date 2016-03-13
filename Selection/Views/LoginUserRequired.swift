//
//  LoginUserRequired.swift
//  Selection
//
//  Created by April on 3/12/16.
//  Copyright © 2016 BuildersAccess. All rights reserved.
//

import Foundation

class LoginUserRequired {
    var email: String
    var password: String
    
    required init(email _email: String, password _pwd: String){
        self.email = _email
        self.password = _pwd
    }

    func toDictionary() -> [String: String]{
        return ["email" : email, "password" : password]
    }
}
