//
//  Clienti.swift
//  FidelioAPP
//
//  Created by Matteo on 28/04/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation

 struct Cliente: Decodable {
    var id: Int?
    var user_id: String?
    
    var nome: String?
    var cognome: String?
    var c_fiscale: String?
    var data_nascita: Date?
    var indirizzo: String?
    var citta: String?
    var provincia: String?
    var cap: String?
    var cellulare: String?
    var email: String?
    
    var created_at: Date?
    var updated_at: Date?
    
    let numKey = 10 // MATTEO: variabile per fare il count del numero delle chiavi della struttura che servono in grafica
}


extension Cliente {
    public enum Keys: String, CodingKey {
        case id = "id"
        case user_id = "user_id"
        case nome = "nome"
        case cognome = "cognome"
        case c_fiscale = "c_fiscale"
        case data_nascita = "data_nascita"
        case indirizzo = "indirizzo"
        case citta = "citta"
        case provincia = "provincia"
        case cap = "cap"
        case cellulare = "cellulare"
        case email = "email"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
    
    

    
    
    init(from decoder: Decoder) throws {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let keyedContainer = try decoder.container(keyedBy: Keys.self)
        id = try keyedContainer.decode(Int.self, forKey: .id)
        user_id = try keyedContainer.decode(String.self, forKey: .user_id)
        nome = try keyedContainer.decode(String.self, forKey: .nome)
        cognome = try keyedContainer.decode(String.self, forKey: .cognome)
        c_fiscale = try keyedContainer.decode(String.self, forKey: .c_fiscale)
        let dataNascita = dateFormatterGet.date(from: try keyedContainer.decode(String.self, forKey: .data_nascita))
        data_nascita = dataNascita
        indirizzo = try keyedContainer.decode(String.self, forKey: .indirizzo)
        citta = try keyedContainer.decode(String.self, forKey: .citta)
        provincia = try keyedContainer.decode(String.self, forKey: .provincia)
        cap = try keyedContainer.decode(String.self, forKey: .cap)
        cellulare = try keyedContainer.decode(String.self, forKey: .cellulare)
        email = try keyedContainer.decode(String.self, forKey: .email)
        let dataCreate = dateFormatterGet.date(from: try keyedContainer.decode(String.self, forKey: .created_at))
        created_at = dataCreate
        let dataUpdate = dateFormatterGet.date(from: try keyedContainer.decode(String.self, forKey: .updated_at))
        updated_at = dataUpdate
        
        
    }
    
    
}
