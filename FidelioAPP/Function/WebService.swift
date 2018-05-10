//
//  WebService.swift
//  FidelioAPP
//
//  Created by Matteo on 28/04/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation
import UIKit


let url = URL(string: "http://fidelio.cormarlab.it/api/auth/login/")!
var token : String = ""
let baseUrl = "http://fidelio.cormarlab.it/api/"


public func httpRequestPost (parameters:  [String: String],nameCall: String) -> [String: Any]?  {
    guard let url = URL(string: baseUrl+nameCall) else { return nil }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return nil }
    request.httpBody = httpBody
    let session = URLSession.shared
    var done = false
    var jsonResult : [String: Any]?
    session.dataTask(with: request) { (data, response, error) in
        if let response = response {
             print(response)
        }
        
        if let data = data {
            do {
               //let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                //print(json)
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                jsonResult = json
                /*let login = Login(json: json)
                print(login)
                print(login.token)*/
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
    
    return jsonResult
}




public func httpRequestGet (nameCall: String) -> Array<Any>? {
    let url = URL(string: baseUrl + nameCall)! //change the url
    let session = URLSession.shared
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    var done = false
    var jsonResult : Array<Any>?
    session.dataTask(with: request) { (data, response, error) in
        if let response = response {
            print(response)
        }
        
        if let data = data {
            do {
                //guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? Array<Any>
                print(json)
                jsonResult = json!
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
    
    return jsonResult
}


