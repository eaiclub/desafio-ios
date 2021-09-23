//
//  AllPhotosViewModel.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import UIKit

let shadesOfGray: [UIColor] = [
    .systemGray6,
    .systemGray5,
    .systemGray4,
    .systemGray3,
    .systemGray2,
    .systemGray
]

class AllPhotosViewModel: ViewModel {
    weak var delegate: ViewModelDelegate?

    private(set) var colors: [UIColor] = [] {
        didSet {
            self.delegate?.updateView()
        }
    }
    
    init() {
        self.colors = shadesOfGray
    }
}
