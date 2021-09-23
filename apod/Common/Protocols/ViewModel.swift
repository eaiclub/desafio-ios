//
//  ViewModel.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import Foundation

protocol ViewModel: AnyObject {
    var delegate: ViewModelDelegate? { get set }
}

protocol ViewModelDelegate: AnyObject {
    func updateView()
}
