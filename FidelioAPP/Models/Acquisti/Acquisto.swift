//
//  Acquisto.swift
//  FidelioAPP
//
//  Created by Matteo on 01/06/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation

struct Acquisto: Decodable {
    var id: Int?
    var cliente_id: String?
    var importo: Double?
    var data_acquisto: Date?
    var created_at: Date?
    var updated_at: Date?
    var user_id: String?
    var cliente: Cliente?
}


extension Acquisto {
    public enum Keys: String, CodingKey {
        case id = "id"
        case cliente_id = "cliente_id"
        case importo = "importo"
        case data_acquisto = "data_acquisto"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case user_id = "user_id"
        case cliente = "cliente"

    }
    
    
    init(from decoder: Decoder) throws {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let keyedContainer = try decoder.container(keyedBy: Keys.self)
        
        id = try keyedContainer.decode(Int.self, forKey: .id)
        cliente_id = try keyedContainer.decode(String.self, forKey: .cliente_id)
        importo = try Double(keyedContainer.decode(String.self, forKey: .importo))
        let dataAcquisto = dateFormatterGet.date(from: try keyedContainer.decode(String.self, forKey: .data_acquisto))
        data_acquisto = dataAcquisto
        let dataCreate = dateFormatterGet.date(from: try keyedContainer.decode(String.self, forKey: .created_at))
        created_at = dataCreate
        let dataUpdate = dateFormatterGet.date(from: try keyedContainer.decode(String.self, forKey: .updated_at))
        updated_at = dataUpdate
        user_id = try keyedContainer.decode(String.self, forKey: .user_id)
        cliente = try keyedContainer.decodeIfPresent(Cliente.self, forKey: .cliente)
    }
    
}

