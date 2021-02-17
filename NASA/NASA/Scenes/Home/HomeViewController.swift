//
//  HomeViewController.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 10/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import UIKit

protocol HomeDisplay : class {
    func showViewModel(viewModel : HomeModels.Planetarium.ViewModel)
}

class HomeViewController: LayoutVerticalViewController, HomeDisplay {
        
    private var planetsListView : PlanetsListView = PlanetsListView()
    
    private var interactor  : HomeInteractor = HomeInteractor()
    private var router      : HomeRouter = HomeRouter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareLayout()
    }
    
    private func prepareLayout() {
        self.navigationItem.title = "Home - Planetários"
        self.planetsListView.delegate = self
        self.add(view: planetsListView)
        self.doLoadScreen()
        self.interactor.presenter?.viewController = self
        self.router.viewController = self
    }
    
    private func doLoadScreen() {
        self.interactor.doLoadScreenInfo()
    }
    
    func showViewModel(viewModel: HomeModels.Planetarium.ViewModel) {
        self.planetsListView.set(viewModel.planetariumModel)
    }
}

extension HomeViewController: PlanetsListViewDelegate {
    
    func didSelectPlanetarium(planetarium: PlanetariumModel, view: PlanetsListView) {
        self.router.routerPlanetariumDetails(planetarium: planetarium)
    }
}
