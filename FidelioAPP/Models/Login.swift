//
//  Login.swift
//  FidelioAPP
//
//  Created by Matteo on 06/05/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation

public struct Login: Decodable {
    var status: String?
    var token: String?
    var expires_in: String?

    
    init(status: String, token: String, indirizzo: String, expires_in: String) {
        self.status = status
        self.token = token
        self.expires_in = expires_in
    }

    
   init(json: [String: Any]) {
        status = json["status"] as? String ?? ""
        token = json["token"] as? String ?? ""
        expires_in = json["expires_in"] as? String ?? ""
    }
        
}
