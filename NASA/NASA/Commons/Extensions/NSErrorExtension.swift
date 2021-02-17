//
//  NSErrorExtension.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 11/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import UIKit

extension NSError {
    static var generic : NSError {
        return NSError(domain: "Ocorreu um erro, por favor, tente novamente", code: -1, userInfo: nil)
    }
}
