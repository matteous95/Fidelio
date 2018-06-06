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
    func getFeed(from loginFeedType: CallFeed, completion: @escaping (Result<Clienti?, APIError>) -> Void) {
        let endpoint = loginFeedType
        //let request = endpoint.request
        let request = endpoint.getRequestGet(withToken: true)
        
        fetch(with: request, decode: { json -> Clienti? in
            guard let clientiResult = json as? Clienti else {
                return  nil
            }
            return clientiResult
        }, completion: completion)
        
        
    }
}
