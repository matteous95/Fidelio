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

    //MATTEO: compogno l'url di default e aggiungo i parametri all'url se servono
    func getUrlComponentr (paramUrl: [String]? = nil) -> URLComponents {
        var components = URLComponents(string: base)!
        //MATTEO: se url ha bisogno di ulteriori parametri li inserisco
        if paramUrl == nil {
            components.path = path
        }else{
            var i = 0
            for par in paramUrl! {
                i = i + 1
                components.path = path.replacingOccurrences(of: "$P" + String(i), with: par)
            }
            //components.path = path.replacingOccurrences(of: "$P", with: paramUrl!)
            //components.path = (path + "/" + paramUrl!)
        }
        return components
    }
    
    //MATTEO: chiamata web service in post
    func getRequestPost(parametri: [String:String]?,withToken: Bool,paramUrl: [String]? = nil) -> URLRequest {
        var Components = getUrlComponentr(paramUrl: paramUrl)
        //MATTEO: verifico se la chiamata ha bisogno del token
        if withToken == true {
            let token = LocalToken.getLocalToken()
            if token != nil {
                //MATTEO: concateno il token
                Components.query = "token=" + (token)!
            }
        }
        let url = Components.url!
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //MATTEO: se ci sono parametri li metto nel http body
        if parametri != nil {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parametri!, options: []) else {
                return request
            }
            print(httpBody)
            request.httpBody = httpBody
        }
        return request
    }
    
    //MATTEO: chiamata web service in get
    func getRequestGet(withToken: Bool,paramUrl: [String]? = nil) -> URLRequest {
        var Components = getUrlComponentr(paramUrl: paramUrl)
        //MATTEO: verifico se la chiamata ha bisogno del token
        if withToken == true {
            let token = LocalToken.getLocalToken()
            if token != nil {
                //MATTEO: concateno il token
                Components.query = "token=" + (token)!
            }
        }
        let url = Components.url!
        print(url)
        return URLRequest(url: url)
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
