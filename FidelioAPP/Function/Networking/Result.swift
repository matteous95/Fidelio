//
//  Result.swift
//  FidelioAPP
//
//  Created by Matteo on 20/05/18.
//  Copyright © 2018 Matteo. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}
