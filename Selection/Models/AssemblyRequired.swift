//
//  AssemblyRequired.swift
//  Selection
//
//  Created by April on 3/12/16.
//  Copyright © 2016 BuildersAccess. All rights reserved.
//

import Foundation

class AssemblyRequired: LoginUserRequired {
    var ciaid: String
    
//    var email: String
//    var password: String
    
    required init(email _email: String, password _pwd: String, ciaid _ciaid: String){
        self.ciaid = _ciaid
        super.init(email: _email, password: _pwd)
    }

    required init(email _email: String, password _pwd: String) {
        self.ciaid = ""
        super.init(email: _email, password: _pwd)
    }
    
    override func toDictionary() -> [String: String]{
        return ["email" : email, "password" : password, "idcia": ciaid]
    }
}
