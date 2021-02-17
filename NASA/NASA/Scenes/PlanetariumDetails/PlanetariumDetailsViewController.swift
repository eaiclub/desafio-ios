//
//  PlanetariumDetailsViewController.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 12/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import UIKit

class PlanetariumDetailsViewController: LayoutVerticalViewController {
    
    private var planetariumDetailsView: PlanetariumDetailsView = PlanetariumDetailsView()
    
    private var planetarium : PlanetariumModel?
    
    init(planetarium: PlanetariumModel) {
        self.planetarium = planetarium
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareLayout()
    }
    
    private func prepareLayout() {
        self.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationItem.title = "Detalhe do Planetário"
        self.planetariumDetailsView.set(self.planetarium)
        self.add(view: planetariumDetailsView)
    }
}
