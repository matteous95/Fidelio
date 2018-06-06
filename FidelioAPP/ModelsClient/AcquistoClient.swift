//
//  AcquistoClient.swift
//  FidelioAPP
//
//  Created by Matteo on 01/06/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation

class AcquistoClient: APIClient {
 
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    //in the signature of the function in the success case we define the Class type thats is the generic one in the API
    func getFeed(paramID: [String] ,from loginFeedType: CallFeed, completion: @escaping (Result<Acquisto?, APIError>) -> Void) {
        let endpoint = loginFeedType
        //let request = endpoint.request
        let request = endpoint.getRequestGet(withToken: true, paramUrl: paramID)
         
        fetch(with: request, decode: { json -> Acquisto? in
            guard let acquistoResult = json as? Acquisto else {
                return  nil
            }
            return acquistoResult
        }, completion: completion)
        
        
    }
}
