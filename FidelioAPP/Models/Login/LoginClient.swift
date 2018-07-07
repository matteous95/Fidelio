//
//  MovieClient.swift
//  FidelioAPP
//
//  Created by Matteo on 20/05/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation


class LoginClient: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    //in the signature of the function in the success case we define the Class type thats is the generic one in the API
    func getFeed(parametres:[String: String]?  ,from loginFeedType: CallFeed, completion: @escaping (Result<Login?, APIError>) -> Void) {
        let endpoint = loginFeedType
        let request = endpoint.getRequestPost(parametriPOST: parametres)
        
        fetch(with: request, decode: { json -> Login? in
            guard let loginResult = json as? Login else {
                return  nil
            }
            return loginResult
        }, completion: completion)
        
    
    }
}


