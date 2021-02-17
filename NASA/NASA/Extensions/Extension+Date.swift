//
//  Extension+Date.swift
//  NASA
//
//  Created by Matheus Pacheco Fusco on 17/02/21.
//  Copyright © 2021 Matheus Pacheco Fusco. All rights reserved.
//

import UIKit

extension Date {
    func toString(format: String = "dd/MM/yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

