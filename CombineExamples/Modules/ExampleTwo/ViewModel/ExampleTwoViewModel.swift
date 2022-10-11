//
//  ExampleTwoViewModel.swift
//  CombineExamples
//
//  Created by Mohamed Elbana on 03/10/2022.
//  Copyright © 2022 Mohamed Elbana. All rights reserved.
//

import Foundation
import Combine

enum ExampleTwoScreenState {
    
    case showLoading
    case hideLoading
    case dataFetched(data: String)
}

class ExampleTwoViewModel {
    
    enum Error: Swift.Error {
        case missingConnection
        case noData
    }
    
    enum State {
        case normal, processing, warning, success
    }
    
    /// Subjects
    let screenSubject = PassthroughSubject<ExampleTwoScreenState, Error>()
    let stateSubject = CurrentValueSubject<State, Error>(.normal)
    
    private func showLoading() {
        screenSubject.send(.showLoading)
    }
    
    private func hideLoading() {
        screenSubject.send(.hideLoading)
    }
    
    private func dataFetched(data: String) {
        screenSubject.send(.dataFetched(data: data))
        screenSubject.send(completion: .finished)
    }
    
    private func notifyError(error: Error) {
        screenSubject.send(completion: .failure(.missingConnection))
    }
    
    func getData() {
        changeState(to: .processing)
        showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.changeState(to: .success)
            self.hideLoading()
            self.dataFetched(data: "Data here now!")
        }
    }
    
    func changeState(to state: State) {
        stateSubject.send(state)
    }
}
