//
//  HomeRouter.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 10/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import UIKit

protocol HomerRouterLogic {
    func routerPlanetariumDetails(planetarium: PlanetariumModel)
}

class HomeRouter: HomerRouterLogic {
    
    weak var viewController : HomeViewController?
    
    func routerPlanetariumDetails(planetarium: PlanetariumModel) {
        let planetariumDetailsViewController = PlanetariumDetailsViewController(planetarium: planetarium)
        self.viewController?.navigationController?.pushViewController(planetariumDetailsViewController, animated: true)
    }
}
