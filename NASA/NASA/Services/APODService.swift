//
//  APODService.swift
//  NASA
//
//  Created by Matheus Pacheco Fusco on 12/02/21.
//  Copyright © 2021 Matheus Pacheco Fusco. All rights reserved.
//

import UIKit

class APODService: BaseService<APOD> {
    func getPictureOfTheDay(success: SuccessHandler, failure: FailureHandler) {
        let serviceUrl = "\(Constants.Api.baseUrl)planetary/apod"
        self.get(url: serviceUrl, success: success, failure: failure)
    }
}
