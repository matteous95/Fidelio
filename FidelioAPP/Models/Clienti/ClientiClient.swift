//
//  ClientiClient.swift
//  FidelioAPP
//
//  Created by Matteo on 24/05/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation

class ClientiClient: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    //in the signature of the function in the success case we define the Class type thats is the generic one in the API
    func getFeed(parametriURL: ParametriUrl? = nil, from loginFeedType: CallFeed, completion: @escaping (Result<pageClienti?, APIError>) -> Void) {
        let endpoint = loginFeedType
        //MATTEO: imposto i parametri dal passare nella query dell'url --> TOKEN & PAGE
        let queryItems = setParamURL(paramStruct: parametriURL)

        //MATTEO: mi preparo la request da fare al ws
        let request = endpoint.getRequestGet(parametriQUERY: queryItems)
        
        fetch(with: request, decode: { json -> pageClienti? in
            guard let clientiResult = json as? pageClienti else {
                return  nil
            }
            return clientiResult
        }, completion: completion)
        
        
    }
    
    func setParamURL (paramStruct: ParametriUrl?) -> [URLQueryItem]? {
        var queryItems:[URLQueryItem]? = []
        if paramStruct?.token != nil {
            queryItems?.append(URLQueryItem(name: "token", value: paramStruct?.token))
        }
        if paramStruct?.page != nil {
            let strPage: String = String((paramStruct?.page!)!)
            queryItems?.append(URLQueryItem(name: "page", value: strPage))
        }
        if paramStruct?.search != nil {
            queryItems?.append(URLQueryItem(name: "search", value: paramStruct?.search))
        }
        return queryItems
    }
    
}
