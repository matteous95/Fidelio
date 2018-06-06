//
//  WebService.swift
//  FidelioAPP
//
//  Created by Matteo on 28/04/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation
import UIKit


//let url = URL(string: "http://fidelio.cormarlab.it/api/auth/login/")!
//var token : String = ""
//let baseUrl = "http://fidelio.cormarlab.it/api/"

public func httpRequestPost (strURL: String, parameters: [String: String]) -> URLRequest? {
    guard let url = URL(string: strURL) else {
        return nil
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
        return nil
    }
    request.httpBody = httpBody
    return request
}


public func httpRequestPostTOT (strURL: String, parameters: [String: String])  {
    guard let url = URL(string: strURL) else {
        return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
        return
    }
    request.httpBody = httpBody
    let session = URLSession.shared

    
    session.dataTask(with: request) { (data, response, error) in
        //MATTEO: se ci sono errori esco
        if error != nil {
            print(error!)
            //return nil
        }
        
        //MATTEO: se ci sono errori esco
        guard let httpResponse = response as? HTTPURLResponse else {
            print(response!)
            return
            //return nil
        }
        
        //MATTEO: se il messaggio non è quello della corretta esecuzione esco
        if httpResponse.statusCode != 200 {
            print(httpResponse)
            //return nil
        }
        
        //MATTEO: se tutto vabene mi prendo il risultato (json)
        if let data = data {
            do {
                print(data)
            } catch {
                print(error)
            }
        }
        }.resume()

}




public func httpRequestGet (strURL: String) {
    let url = URL(string: strURL)! //change the url
    let session = URLSession.shared
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    var done = false
    session.dataTask(with: request) { (data, response, error) in
        //MATTEO: se ci sono errori esco
        if error != nil {
            print(error!)
            return
        }
        
        //MATTEO: se ci sono errori esco
        guard let httpResponse = response as? HTTPURLResponse else {
            print(response!)
            return
        }
        
        //MATTEO: se il messaggio non è quello della corretta esecuzione esco
        if httpResponse.statusCode != 200 {
            print(httpResponse)
            return
        }
        
        //MATTEO: se tutto vabene mi prendo il risultato (json)
        if let data = data {
            do {
                print(data)
                done = true
            } catch {
                print(error)
                done = true
            }
        }
        }.resume()
    repeat {
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
    } while !done
    return
}


