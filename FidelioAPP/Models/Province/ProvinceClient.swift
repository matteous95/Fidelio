//
//  ProvinceClient.swift
//  FidelioAPP
//
//  Created by Matteo on 05/08/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation


class ProvinceClient: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    //in the signature of the function in the success case we define the Class type thats is the generic one in the API
    func getFeed(from loginFeedType: CallFeed, completion: @escaping (Result<Province?, APIError>) -> Void) {
        let endpoint = loginFeedType
        
        
        //MATTEO: imposto i parametri dal passare nella query dell'url --> TOKEN & PAGE
        var queryItems: [URLQueryItem]?
        queryItems = [URLQueryItem(name: "token", value: LocalStorage.getLocalToken())]

        
        //MATTEO: mi preparo la request da fare al ws
        let request = endpoint.getRequestGet(parametriQUERY: queryItems)
        
        fetch(with: request, decode: { json -> Province? in
            guard let provinceResult = json as? Province else {
                return  nil
            }
            return provinceResult
        }, completion: completion)
        
        
    }
}
