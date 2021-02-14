//
//  RoverPhotosService.swift
//  NASA
//
//  Created by Matheus Pacheco Fusco on 13/02/21.
//  Copyright © 2021 Matheus Pacheco Fusco. All rights reserved.
//

import UIKit

class RoverPhotosService: BaseService<RoverPhotos> {
    
    var page: Int = 1
    var camera: RoverPhotoCamera?
    var cameraType: RoverPhotoCameraType?
    
    func getRoversPhotos(type: RoverPhotoCameraType, camera: RoverPhotoCamera, success: SuccessHandler, failure: FailureHandler) {

        self.resetRequestIfNeeded(type: type, camera: camera)
        
        let serviceUrl = "\(Constants.Api.baseUrl)mars-photos/api/v1/rovers/\(type.rawValue)/photos"
        
        var params = Constants.Params.defaultParams
        params.updateValue("1000", forKey: "sol")
        params.updateValue("\(page)", forKey: "page")
        
        if camera != .all {
            params.updateValue("\(camera.rawValue)", forKey: "camera")
        }
        
        page += 1
        self.get(url: serviceUrl, params: params, success: success, failure: failure)
    }
    
    private func resetRequestIfNeeded(type: RoverPhotoCameraType, camera: RoverPhotoCamera) {
        if let _type = self.cameraType, _type != type {
            self.page = 1
        }
        
        if let _camera = self.camera, _camera != camera {
            self.page = 1
        }
        
        self.cameraType = type
        self.camera = camera
    }
}
