//
//  Province.swift
//  FidelioAPP
//
//  Created by Matteo on 05/08/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation

struct Provincia: Decodable {
    var id: Int?
    var provincia: String?
    var slug: String?
    var abbr: String?
    var codice_provincia_istat: String?
    var codice_regione_istat: String?
    var created_at: Date?
    var updated_at: Date?
}



extension Provincia {
    public enum Keys: String, CodingKey {
        case id = "id"
        case provincia = "provincia"
        case slug = "slug"
        case abbr = "abbr"
        case codice_provincia_istat = "codice_provincia_istat"
        case codice_regione_istat = "codice_regione_istat"
        case created_at = "created_at"
        case updated_at = "updated_at"
        
    }
    
    
    init(from decoder: Decoder) throws {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let keyedContainer = try decoder.container(keyedBy: Keys.self)
        
        id = try keyedContainer.decode(Int.self, forKey: .id)
        provincia = try keyedContainer.decode(String.self, forKey: .provincia)
        slug = try keyedContainer.decode(String.self, forKey: .slug)
        abbr = try keyedContainer.decode(String.self, forKey: .abbr)
        codice_provincia_istat = try keyedContainer.decode(String.self, forKey: .codice_provincia_istat)
        codice_regione_istat = try keyedContainer.decode(String.self, forKey: .codice_regione_istat)
        let dataCreate = dateFormatterGet.date(from: try keyedContainer.decode(String.self, forKey: .created_at))
        created_at = dataCreate
        let dataUpdate = dateFormatterGet.date(from: try keyedContainer.decode(String.self, forKey: .updated_at))
        updated_at = dataUpdate
    }
    
}
