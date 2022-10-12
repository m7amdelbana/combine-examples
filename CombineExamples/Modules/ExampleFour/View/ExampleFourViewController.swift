//
//  ExampleFourViewController.swift
//  CombineExamples
//
//  Created by Mohamed Elbana on 12/10/2022.
//  Copyright © 2022 Mohamed Elbana. All rights reserved.
//

import UIKit
import Combine

class ExampleFourViewController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    
    private var cancellable: AnyCancellable?
    private let imageUrl = "https://picsum.photos/300/300"
    private let placeholder = UIImage(named: "logo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
    }
    
    private func loadImage() {
        cancellable = ImageProcessor()
            .process(imageUrl)
            .replaceError(with: placeholder)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: img)
    }
    
    private func loadImageWithSink() {
        cancellable = ImageProcessor()
            .process(imageUrl)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { image in
                self.img.image = image
            })
    }
}
