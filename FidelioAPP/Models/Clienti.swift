//
//  Clienti.swift
//  FidelioAPP
//
//  Created by Matteo on 24/05/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation

struct Clienti: Decodable{
    var results : [Cliente]?
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var arrayClienti : [Cliente]? = []
        print(container.count as Any)
        while !container.isAtEnd {
            if let value = try? container.decode(Cliente.self) as Cliente {
                let Cliente: Cliente = value
                arrayClienti?.append(Cliente)
            }
        }
         self.results = arrayClienti
    }
    
}






