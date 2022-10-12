//
//  HomeViewController.swift
//  CombineExamples
//
//  Created by Mohamed Elbana on 03/10/2022.
//  Copyright © 2022 Mohamed Elbana. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    init() {
        super.init(nibName: String(describing: Self.self),
                   bundle: .init(for: Self.self))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionExample(_ sender: UIButton) {
        switch sender.tag {
        case 1: push(of: ExampleOneViewController())
        case 2: push(of: ExampleTwoViewController())
        case 3: push(of: ExampleThreeViewController())
        case 4: push(of: ExampleFourViewController())
        default: break
        }
    }
    
    private func push(of vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
