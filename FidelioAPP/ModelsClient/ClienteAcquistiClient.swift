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
    func getFeed(paramID: [String] ,from loginFeedType: CallFeed, completion: @escaping (Result<Acquisti?, APIError>) -> Void) {
        let endpoint = loginFeedType
        let request = endpoint.getRequestGet(withToken: true,paramUrl: paramID)
        
        fetch(with: request, decode: { json -> Acquisti? in
            guard let acquistiResult = json as? Acquisti else {
                return  nil
            }
            return acquistiResult
        }, completion: completion)
        
        
    }
}
