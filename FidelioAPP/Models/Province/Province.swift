//
//  Province.swift
//  FidelioAPP
//
//  Created by Matteo on 05/08/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation

struct Province: Decodable{
    var results : [Provincia]?
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var arrayProvince : [Provincia]? = []
        while !container.isAtEnd {
            if let value = try? container.decode(Provincia.self) as Provincia {
                let Provincia: Provincia = value
                arrayProvince?.append(Provincia)
            }
        }
        self.results = arrayProvince
    }
}
