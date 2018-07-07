//
//  Endpoint.swift
//  FidelioAPP
//
//  Created by Matteo on 20/05/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation



protocol Endpoint {
    
    var base: String { get }
    var path: String { get }
}

extension Endpoint {
    
    //MATTEO: chiamata web service in post
    //parametri -> parametri delle chiamate in post httpBody
    //withToken -> se la chiamat ha bisogno o no del token
    //paramUrl -> parametri presenti in chiaro nell'url

    func getRequestPost(parametriPOST: [String:String]? = nil, parametriQUERY: [URLQueryItem]? = nil, parametriURL: [String]? = nil) -> URLRequest {
        let Components = getUrlComponent(paramUrl: parametriURL, paramQuery: parametriQUERY)
        let url = Components.url!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //MATTEO: se ci sono parametri POST li metto nel http body
        if parametriPOST != nil {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parametriPOST!, options: []) else {
                return request
            }
            request.httpBody = httpBody
        }
        return request
    }
    
    //MATTEO: chiamata web service in get
    //withToken -> se la chiamat ha bisogno o no del token
    //paramUrl -> parametri presenti in chiaro nell'url
    func getRequestGet(parametriQUERY: [URLQueryItem]? = nil, parametriURL: [String]? = nil) -> URLRequest {
        let Components = getUrlComponent(paramUrl: parametriURL, paramQuery: parametriQUERY)
        let url = Components.url!
        return URLRequest(url: url)
    }
    
    
    //MATTEO: compogno l'url di default e aggiungo i parametri all'url se servono
    func getUrlComponent (paramUrl: [String]? = nil, paramQuery: [URLQueryItem]? = nil) -> URLComponents {
        var components = URLComponents(string: base)!
        
        //MATTEO: se url ha bisogno di ulteriori parametri li inserisco
        if paramUrl == nil {
            components.path = path
        }else{
            var i = 0
            //MATTEO: ciclo tutti i parametri che mi servono e li sostituisco nell'url
            for par in paramUrl! {
                i = i + 1
                components.path = path.replacingOccurrences(of: "$P" + String(i), with: par)
            }
        }
        
        //MATTEO: verifico se la chiamata ha bisogno del token
        if paramQuery != nil {
            //MATTEO: concateno il token e gli altri parametri della query (ES. page)
            components.queryItems = paramQuery!
        }
        return components
    }
    
}



//MATTEO: elenco chiamate presente nel web service
enum CallFeed {
    //AUTH
    case callLogin
    case callSignup
    case callRecovery
    case callReset
    case callRefresh
    case callMe
    
    //USER
    case callClienti
    case callCliente
    case callAcquisti
    case callClienteAcquisti
    
}

extension CallFeed: Endpoint {
    
    var base: String {
        return "http://fidelio.cormarlab.it"
    }
    
    var path: String {
        switch self {
        case .callLogin: return "/api/auth/login"
        case .callSignup: return "/api/auth/signup"
        case .callRecovery: return "/api/auth/recovery"
        case .callReset: return "/api/auth/reset"
        case .callRefresh: return "/api/auth/refresh"
        case .callMe: return "/api/auth/me"
            
        case .callClienti: return "/api/user/clienti"
        case .callCliente: return "/api/user/clienti/$P1"
        case .callAcquisti: return "/api/user/acquisti"
        case .callClienteAcquisti: return "/api/user/clienti/$P1/acquisti"

        }

        
    }

}
