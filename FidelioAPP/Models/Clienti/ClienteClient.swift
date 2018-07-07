//
//  ClienteClient.swift
//  FidelioAPP
//
//  Created by Matteo on 25/05/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation

class ClienteClient: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    //in the signature of the function in the success case we define the Class type thats is the generic one in the API
    func getFeed(paramID: [String] ,from loginFeedType: CallFeed, completion: @escaping (Result<Cliente?, APIError>) -> Void) {
        let endpoint = loginFeedType
        //MATTEO: imposto i parametri necessari alla query dell'url --> TOKEN
        let queryItems = [URLQueryItem(name: "token", value: LocalStorage.getLocalToken())]
        //MATTEO: mi preparo la request da fare al ws
        let request = endpoint.getRequestGet(parametriQUERY: queryItems, parametriURL: paramID)
        
        fetch(with: request, decode: { json -> Cliente? in
            guard let clientiResult = json as? Cliente else {
                return  nil
            }
            return clientiResult
        }, completion: completion)
        
        
    }
}
