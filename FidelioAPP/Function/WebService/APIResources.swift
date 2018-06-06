//
//  APIResources.swift
//  FidelioAPP
//
//  Created by Matteo on 15/05/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation

struct ApiWrapper {
    let items: [Serialization]
}

extension ApiWrapper {
    private enum Keys: String, SerializationKey {
        case items
    }
    
    init(serialization: Serialization) {
        items = serialization.value(forKey: Keys.items) ?? []
    }
}

protocol ApiResource {
    associatedtype Model
    var methodPath: String { get }
    func makeModel(serialization: Serialization) -> Model
}

extension ApiResource {
    var url: URL {
        let baseUrl = "http://fidelio.cormarlab.it/api"
        let url = baseUrl + methodPath
        return URL(string: url)!
    }
    
    func makeModel(data: Data) -> [Model]? {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
            return nil
        }
        print(json)
        guard let jsonSerialization = json as? Serialization else {
            return nil
        }
        print(jsonSerialization)

        let wrapper = ApiWrapper(serialization: jsonSerialization)
        return wrapper.items.map(makeModel(serialization:))
        
    
    }
}

struct LoginResource: ApiResource {
    let methodPath = "/auth/login"
    
    func makeModel(serialization: Serialization) -> Login {
        return Login(serialization: serialization)
    }
}

struct ClienteResource: ApiResource {
    let methodPath = "/user/cliente"
    
    func makeModel(serialization: Serialization) -> Cliente {
        return Cliente(serialization: serialization)
    }
}
