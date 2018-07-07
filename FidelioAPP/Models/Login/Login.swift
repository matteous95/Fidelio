//
//  Login.swift
//  FidelioAPP
//
//  Created by Matteo on 06/05/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation

 struct Login: Decodable {
    var status: String?
    var token: String?
    var expires_in: Int?
    }


extension Login {
    private enum Keys: String, CodingKey {
        case status
        case token
        case expires_in
    }
    

    init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: Keys.self)
        status = try keyedContainer.decode(String.self, forKey: .status)
        token = try keyedContainer.decode(String.self, forKey: .token)
        expires_in = try keyedContainer.decode(Int.self, forKey: .expires_in)
    }
    

    }
 

