//
//  ClienteAcquistiClient.swift
//  FidelioAPP
//
//  Created by Matteo on 02/06/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation

class ClienteAcquistiClient: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    //in the signature of the function in the success case we define the Class type thats is the generic one in the API
    func getFeed(page: Int? = nil, paramID: [String],from loginFeedType: CallFeed, completion: @escaping (Result<pageAcquisti?, APIError>) -> Void) {
        let endpoint = loginFeedType
        
        //MATTEO: imposto i parametri necessari alla query dell'url --> TOKEN
        var queryItems: [URLQueryItem]?
        if page == nil {
             queryItems = [URLQueryItem(name: "token", value: LocalStorage.getLocalToken())]
        }else{
             queryItems = [URLQueryItem(name: "token", value: LocalStorage.getLocalToken()),URLQueryItem(name: "page", value: String(page!))]
        }
        
        //MATTEO: mi preparo la request da fare al ws
        let request = endpoint.getRequestGet(parametriQUERY: queryItems, parametriURL: paramID)
        
        fetch(with: request, decode: { json -> pageAcquisti? in
            guard let acquistiResult = json as? pageAcquisti else {
                return  nil
            }
            return acquistiResult
        }, completion: completion)
        
        
    }
}
