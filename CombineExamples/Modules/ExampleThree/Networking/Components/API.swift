//
//  API.swift
//  CombineExamples
//
//  Created by Mohamed Elbana on 03/10/2022.
//  Copyright © 2022 Mohamed Elbana. All rights reserved.
//

import Foundation

class API {
    
    private static let baseUrl = "https://jsonplaceholder.typicode.com"
    
    static let posts = URL(string: "\(API.baseUrl)/posts")
    static let todos = URL(string: "\(API.baseUrl)/todos")
}
