//
//  Extension+String.swift
//  NASA
//
//  Created by Matheus Pacheco Fusco on 17/02/21.
//  Copyright © 2021 Matheus Pacheco Fusco. All rights reserved.
//

import UIKit

extension String {
    func toDate(format: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from:self)
    }
}
