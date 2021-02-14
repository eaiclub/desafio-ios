//
//  HomePresenter.swift
//  NASA
//
//  Created by Matheus Pacheco Fusco on 14/02/21.
//  Copyright © 2021 Matheus Pacheco Fusco. All rights reserved.
//

import UIKit
import Alamofire

class HomePresenter: NSObject {
    let roverCameras = RoverCameras()
    private(set) var selectedCamera: RoverPhotoCamera = .fhaz
    private(set) var selectedCameraType: RoverPhotoCameraType = .curiosity
    private(set) var apod: APOD?
    private(set) var roverPhotos: [RoverPhoto] = []
    private var page = 1
    
    func getPictureOfTheDay(success: SuccessHandler, failure: FailureHandler) {
        APODService().getPictureOfTheDay(success: { result in
            guard let apod = result as? APOD else {
                failure?(AFError.explicitlyCancelled)
                return
            }
            self.apod = apod
            success?(nil)
        }) { (error) in
            failure?(error)
        }
    }
    
    func getRoversPhotos(type: RoverPhotoCameraType, camera: RoverPhotoCamera, success: SuccessHandler, failure: FailureHandler) {
        self.resetRequestIfNeeded(type: type, camera: camera)
        RoverPhotosService().getRoversPhotos(type: type, camera: camera, page: self.page, success: { (result) in
            guard let roverPhotos = result as? RoverPhotos else {
                failure?(AFError.explicitlyCancelled)
                return
            }
            self.roverPhotos += roverPhotos.photos
            success?(nil)
        }) { (error) in
            failure?(error)
        }
    }
    
    private func resetRequestIfNeeded(type: RoverPhotoCameraType, camera: RoverPhotoCamera) {
        if type != self.selectedCameraType {
            self.page = 1
            self.roverPhotos.removeAll()
        }
        
        if camera != self.selectedCamera {
            self.page = 1
            self.roverPhotos.removeAll()
        }
        self.selectedCamera = camera
        self.selectedCameraType = type
    }
}
