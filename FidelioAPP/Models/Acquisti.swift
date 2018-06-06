//
//  Acquisti.swift
//  FidelioAPP
//
//  Created by Matteo on 01/06/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation

struct Acquisti: Decodable{
    var results : [Acquisto]?
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var arrayClienti : [Acquisto]? = []
        print(container.count as Any)
        while !container.isAtEnd {
            if let value = try? container.decode(Acquisto.self) as Acquisto {
                let Acquisto: Acquisto = value
                arrayClienti?.append(Acquisto)
            }
        }
        self.results = arrayClienti
    }
}
