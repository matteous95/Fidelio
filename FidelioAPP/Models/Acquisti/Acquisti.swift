//
//  Acquisti.swift
//  FidelioAPP
//
//  Created by Matteo on 01/06/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation

//MATTEO: struttura dei clienti che serve per la paginazione
struct pageAcquisti: Decodable {
    var current_page : Int?
    var risAcquisti: Acquisti?
    var first_page_url: String?
    var from: Int?
    var last_page: Int?
    var last_page_url: String?
    var next_page_url: String?
    var path: String?
    var per_page: Int?
    var prev_page_url: String?
    var to: Int?
    var total: Int?
}

extension pageAcquisti {
    public enum Keys: String, CodingKey {
        case current_page = "current_page"
        case data = "data"
        case first_page_url = "first_page_url"
        case from = "from"
        case last_page = "last_page"
        case last_page_url = "last_page_url"
        case next_page_url = "next_page_url"
        case path = "path"
        case per_page = "per_page"
        case prev_page_url = "prev_page_url"
        case to = "to"
        case total = "total"
    }
    
    
    init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: Keys.self)
        current_page = try? keyedContainer.decode(Int.self, forKey: .current_page)
        first_page_url = try? keyedContainer.decode(String.self, forKey: .first_page_url)
        from = try? keyedContainer.decode(Int.self, forKey: .from)
        last_page = try? keyedContainer.decode(Int.self, forKey: .last_page)
        last_page_url = try? keyedContainer.decode(String.self, forKey: .last_page_url)
        next_page_url = try? keyedContainer.decode(String.self, forKey: .next_page_url)
        path = try? keyedContainer.decode(String.self, forKey: .path)
        per_page = try keyedContainer.decode(Int.self, forKey: .per_page)
        prev_page_url = try? keyedContainer.decode(String.self, forKey: .prev_page_url)
        to = try? keyedContainer.decode(Int.self, forKey: .to)
        total = try? keyedContainer.decode(Int.self, forKey: .total)
        risAcquisti = try keyedContainer.decodeIfPresent(Acquisti.self, forKey: .data)
    }
    
}


//MATTEO: struttura per lo storico degli acquisti di un cliente
struct Acquisti: Decodable{
    var results : [Acquisto]?
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var arrayAcquisti : [Acquisto]? = []
        while !container.isAtEnd {
            if let value = try? container.decode(Acquisto.self) as Acquisto {
                let Acquisto: Acquisto = value
                arrayAcquisti?.append(Acquisto)
            }
        }
        self.results = arrayAcquisti
    }
}
