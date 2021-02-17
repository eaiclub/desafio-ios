//
//  HomeModels.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 10/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import UIKit

enum HomeModels {
    
    enum Planetarium {
        struct Request {
        }
        struct Response {
            var planetariumModel : [PlanetariumModel]
        }
        struct ViewModel {
            var planetariumModel : [PlanetariumModel]
        }
    }
}
