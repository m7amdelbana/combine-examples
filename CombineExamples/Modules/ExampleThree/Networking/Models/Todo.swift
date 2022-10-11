//
//  Todo.swift
//  CombineExamples
//
//  Created by Mohamed Elbana on 12/10/2022.
//  Copyright © 2022 Mohamed Elbana. All rights reserved.
//

import Foundation

struct Todo: Codable {
    
    let id: Int
    let title: String
    let completed: Bool
    let userId: Int
}
