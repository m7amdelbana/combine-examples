//
//  ImageProcessor.swift
//  CombineExamples
//
//  Created by Mohamed Elbana on 12/10/2022.
//  Copyright © 2022 Mohamed Elbana. All rights reserved.
//

import UIKit
import Combine

struct ImageProcessor {
    
    enum Error: Swift.Error {
        case invalidUrl
        case invalidImage
    }
    
    func process(_ url: String) -> Future<UIImage?, Error> {
        Future { promise in
            guard let url = URL(string: url) else {
                return promise(.failure(Error.invalidUrl))
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                      let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                      let data = data, error == nil,
                      let image = UIImage(data: data)
                else {
                    return promise(.failure(Error.invalidImage))
                }
                
                DispatchQueue.main.async {
                    return promise(.success(image))
                }
            }.resume()
        }
    }
}
