//
//  ExampleTwoViewController.swift
//  CombineExamples
//
//  Created by Mohamed Elbana on 03/10/2022.
//  Copyright © 2022 Mohamed Elbana. All rights reserved.
//

import UIKit
import Combine

class ExampleTwoViewController: UIViewController {
    
    private let viewModel = ExampleTwoViewModel()
    private let loading = LoadingController()
    
    /// Cancellable
    private var cancellable: AnyCancellable?
    private var cancellables = [AnyCancellable]()
    
    init() {
        super.init(nibName: String(describing: Self.self),
                   bundle: .init(for: Self.self))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubscribers()
        viewModel.getData()
    }
    
    private func setupSubscribers() {
        /// PassthroughSubject
        cancellable = viewModel.screenSubject.sink { completion in
            switch completion {
            case .finished: break
            case .failure(_): break
            }
        } receiveValue: { state in
            switch state {
            case .showLoading: self.showLoading()
            case .hideLoading: self.hideLoading()
            case let .dataFetched(data): self.presentAlert(message: data)
            }
        }
        
        /// CurrentValueSubject
        viewModel.stateSubject.sink { _ in
            
        } receiveValue: { state in
            if state == .normal {
                self.view.backgroundColor = .systemMint
            } else if state == .success {
                self.view.backgroundColor = .systemGreen
            }
        }.store(in: &cancellables)
    }
    
    private func showLoading() {
        loading.show()
    }
    
    private func hideLoading() {
        loading.close()
    }
    
    private func presentAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
