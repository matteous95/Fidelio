//
//  LocalStorage.swift
//  FidelioAPP
//
//  Created by Matteo on 01/06/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation

public class LocalStorage{
    //MATTEO: scrivo il token nella local storage
    static func setLocalToken (token: String) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: "token")
    }
    
    //MATTEO: leggo il token dalla local storage
    static func getLocalToken () -> String? {
        let defaults = UserDefaults.standard
        if let strToken = defaults.string(forKey: "token") {
            return strToken
        }
        return nil
    }
    
    //MATTEO: elimino il token dalla local storage
    static func  deleteLocalToken() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "token")
    }
    
}
