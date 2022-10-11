//
//  Post.swift
//  CombineExamples
//
//  Created by Mohamed Elbana on 04/10/2022.
//  Copyright © 2022 Mohamed Elbana. All rights reserved.
//

import Foundation

struct Post: Codable {
    
    let id: Int
    let title: String
    let body: String
    let userId: Int
}
