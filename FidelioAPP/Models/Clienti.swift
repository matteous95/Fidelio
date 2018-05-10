//
//  Clienti.swift
//  FidelioAPP
//
//  Created by Matteo on 28/04/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation

public struct Cliente: Decodable {
    var id: Int?
    var ragione_sociale: String?
    var indirizzo: String?
    var email: String?
    var password: String?
    var remember_token: String?
    var create_at: Date?
    var update_at: Date?
    
    
    init(json: [String:Any]){
        self.id = json["id"] as? Int
        self.ragione_sociale = json["rag_sociale"] as? String ?? ""
        self.indirizzo = json["indirizzo"] as? String ?? ""
        self.email = json["email"] as? String ?? ""
        self.password = json["password"] as? String ?? ""
        self.remember_token = json["remember_token"] as? String ?? ""
        self.create_at = json["create_at"] as? Date ?? nil
        self.update_at = json["update_at"] as? Date ?? nil
    }
    
    init(id: Int, ragione_sociale: String, indirizzo: String, email: String, password: String, remember_token: String,create_at: Date,update_at: Date) {
        self.id = id
        self.ragione_sociale = ragione_sociale
        self.indirizzo = indirizzo
        self.email = email
        self.password = password
        self.remember_token = remember_token
        self.create_at = create_at
        self.update_at = update_at

    }
}
