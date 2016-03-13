
//
//  File.swift
//  Selection
//
//  Created by April on 3/13/16.
//  Copyright © 2016 BuildersAccess. All rights reserved.
//

import Foundation
class AssemblySelectionRequired: LoginUserRequired {
    var ciaid: String
    var idassembly: String
    
    //    var email: String
    //    var password: String
    
    required init(email _email: String, password _pwd: String, ciaid _ciaid: String, idassembly: String){
        self.ciaid = _ciaid
        self.idassembly = idassembly
        super.init(email: _email, password: _pwd)
    }
    
    required init(email _email: String, password _pwd: String) {
        self.ciaid = ""
        self.idassembly = ""
        super.init(email: _email, password: _pwd)
    }
    
    override func toDictionary() -> [String: String]{
        return ["email" : email, "password" : password, "idcia": ciaid, "idassembly": idassembly]
    }
}