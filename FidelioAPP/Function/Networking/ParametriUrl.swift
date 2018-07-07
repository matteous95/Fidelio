//
//  ParametriUrl.swift
//  FidelioAPP
//
//  Created by Matteo on 30/06/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation

struct ParametriUrl {
    var token: String?
    var page: Int?
    var search: String?
    
    init(token: String?, page: Int?, search: String?) {
        self.token = token
        self.page = page
        self.search = search
    }
}
