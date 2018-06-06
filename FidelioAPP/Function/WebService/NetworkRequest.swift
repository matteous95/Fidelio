//
//  NetworkRequest.swift
//  FidelioAPP
//
//  Created by Matteo on 15/05/18.
//  Copyright © 2018 Matteo. All rights reserved.
//


import Foundation
import UIKit

protocol NetworkRequest: class {
    associatedtype Model
    func load(parameters: [String: String]?,withCompletion completion: @escaping (Model?) -> Void)
    func decode(_ data: Data) -> Model?
}

extension NetworkRequest {
    fileprivate func load(_ url: URL,parameters: [String: String]?, withCompletion completion: @escaping (Model?) -> Void) {
        var request = URLRequest(url: url)
        //MATTEO: vedo se è una chiamata con parametri o senza
        if parameters == nil {
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } else {
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters!, options: []) else {
                return
            }
            request.httpBody = httpBody
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(self?.decode(data))
        })
        task.resume()
    }
}

class ApiRequest<Resource: ApiResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension ApiRequest: NetworkRequest {
    
    func decode(_ data: Data) -> [Resource.Model]? {
        return resource.makeModel(data: data)
    }
    
    func load(parameters: [String: String]?,withCompletion completion: @escaping ([Resource.Model]?) -> Void) {
        self.load(resource.url, parameters: parameters, withCompletion: completion)
        
    }
}

class ImageRequest {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
}

extension ImageRequest: NetworkRequest {
    func decode(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    
    func load(parameters: [String: String]?,withCompletion completion: @escaping (UIImage?) -> Void) {
        self.load(url, parameters: parameters, withCompletion: completion)
    }
}

