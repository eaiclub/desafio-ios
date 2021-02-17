//
//  HomeInteractor.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 10/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import UIKit

class HomeInteractor {
    
    var presenter : HomePresenter?
    private var worker : HomeWorker?
    
    init() {
        self.presenter  = HomePresenter()
        self.worker     = HomeWorker()
    }
    
    func doLoadScreenInfo() {
        AppLoading.show()
        self.worker?.fetchPlanetarium(completion: { planetarium in
            let response = HomeModels.Planetarium.Response(planetariumModel: planetarium)
            self.presenter?.planetariumPresentation(response: response)
            AppLoading.stop()
        }, failure: { error in
            AppLoading.stop()
        })
    }
}
