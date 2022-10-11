//
//  APIError.swift
//  CombineExamples
//
//  Created by Mohamed Elbana on 04/10/2022.
//  Copyright © 2022 Mohamed Elbana. All rights reserved.
//

import Foundation

enum APIError: Error {
    
    case noResponse
    case know(statusCode: Int)
    case failure(error: Error)
}
