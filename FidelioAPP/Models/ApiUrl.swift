//
//  ApiUrl.swift
//  FidelioAPP
//
//  Created by Matteo on 16/05/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation


public class ApiUrl {
    public let signupURL : String =  getBaseUrl() + "/auth/signup"
    let loginURL : String = getBaseUrl() + "/auth/login"
    let recoveryURL : String = getBaseUrl() + "/auth/recovery"
    let resetURL : String = getBaseUrl() + "/auth/reset"
    let logoutURL : String = getBaseUrl() + "/auth/logout"
    let refreshURL : String = getBaseUrl() + "/auth/refresh"
    let meURL : String = getBaseUrl() + "/auth/me"
    let userURL : String = getBaseUrl() + "/user/user"
    let clientiURL : String = getBaseUrl() + "/user/clienti"
    let clienteURL : String = getBaseUrl() + "/user/cliente"
    let acquistiURL : String = getBaseUrl() + "/user/acquisti"
}

public func getBaseUrl () -> String {
    let baseURL: String = "http://fidelio.cormarlab.it/api"
    return baseURL
}
