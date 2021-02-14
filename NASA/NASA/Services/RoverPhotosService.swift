//
//  RoverPhotosService.swift
//  NASA
//
//  Created by Matheus Pacheco Fusco on 13/02/21.
//  Copyright © 2021 Matheus Pacheco Fusco. All rights reserved.
//

import UIKit

class RoverPhotosService: BaseService<RoverPhotos> {
    var camera: RoverPhotoCamera?
    var cameraType: RoverPhotoCameraType?
    
    func getRoversPhotos(type: RoverPhotoCameraType, camera: RoverPhotoCamera, page: Int, success: SuccessHandler, failure: FailureHandler) {

        let serviceUrl = "\(Constants.Api.baseUrl)mars-photos/api/v1/rovers/\(type.rawValue)/photos"
        
        var params = Constants.Params.defaultParams
        params.updateValue("1000", forKey: "sol")
        params.updateValue("\(page)", forKey: "page")
        
        if camera != .all {
            params.updateValue("\(camera.rawValue)", forKey: "camera")
        }

        self.get(url: serviceUrl, params: params, success: success, failure: failure)
    }
}
