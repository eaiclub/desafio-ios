//
//  ViewConfigurator.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 10/01/21.
//

import Foundation

protocol ViewConfigurator {
    func setupViewConfiguration()
    func buildViewHierarchy()
    func configureViews()
    func setupConstraints()
}

extension ViewConfigurator {
    func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }

    func configureViews() {}
}
