//
//  HomeViewController.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 10/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import UIKit

class HomeViewController: LayoutVerticalViewController {
    
    private var planetsListView : PlanetsListView = PlanetsListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareLayout()
    }
    
    private func prepareLayout() {
        self.add(view: planetsListView)
        
    }
}
