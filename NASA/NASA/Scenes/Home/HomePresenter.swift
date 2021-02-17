//
//  HomePresenter.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 10/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import UIKit

protocol PlanetariumPresentation {
    func planetariumPresentation(response : HomeModels.Planetarium.Response)
}

class HomePresenter: PlanetariumPresentation {
    
    weak var viewController : HomeDisplay?
    
    func planetariumPresentation(response: HomeModels.Planetarium.Response) {
        let viewModel = HomeModels.Planetarium.ViewModel(planetariumModel: response.planetariumModel)
        self.viewController?.showViewModel(viewModel: viewModel)
    }
}
