//
//  ExampleOneViewController.swift
//  CombineExamples
//
//  Created by Mohamed Elbana on 03/10/2022.
//  Copyright © 2022 Mohamed Elbana. All rights reserved.
//

import UIKit
import Combine

class ExampleOneViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    @Published private var password: String = ""
    @Published private var acceptTermsAndConditions: Bool = false
    
    private var buttonSubscriber: AnyCancellable?
    
    private var validToSubmit: AnyPublisher<Bool, Never> {
        return Publishers
            .CombineLatest($password, $acceptTermsAndConditions)
            .map { password, acceptTermsAndConditions in
                return self.isValid(of: password, and: acceptTermsAndConditions)
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        super.init(nibName: String(describing: Self.self),
                   bundle: .init(for: Self.self))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.addTarget(self,
                                    action: #selector(passwordChanged),
                                    for: .editingChanged)
        
        buttonSubscriber = validToSubmit
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: submitButton)
    }
    
    private func isValid(of password: String, and acceptTermsAndConditions: Bool) -> Bool {
        return !password.isEmpty && password.count >= 6 && acceptTermsAndConditions
    }
    
    @objc func passwordChanged() {
        password = passwordTextField.text ?? ""
    }
    
    @IBAction func acceptTermsAndConditions(_ sender: UISwitch) {
        acceptTermsAndConditions = sender.isOn
    }
    
    @IBAction func actionSubmit(_ sender: Any) {
        
    }
}


