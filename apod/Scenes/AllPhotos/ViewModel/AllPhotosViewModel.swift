//
//  AllPhotosViewModel.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import UIKit

class AllPhotosViewModel: ViewModel {
    weak var delegate: ViewModelDelegate?

    private(set) var apods: [Apod] = [] {
        didSet {
            self.delegate?.updateView()
        }
    }
    
    func loadApods() {
        let now: Date = .init()
        let pastDate = Calendar.current.date(byAdding: .day, value: -6, to: now)!
        
        ApodRepository.getApods(from: now, ultil: pastDate) { [weak self] apods in
            self?.apods = apods
        } onFailure: { error in
            print(error)
        }
    }
}
