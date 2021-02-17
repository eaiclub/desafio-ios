//
//  HTTPDomain.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 11/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import UIKit

protocol HTTPDomain {
    var environment : HTTPEnvironment { get }
}

extension HTTPDomain {
    
    var environment : HTTPEnvironment {
        return .dev
    }
}

