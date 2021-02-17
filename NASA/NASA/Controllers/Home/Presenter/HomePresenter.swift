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
    var hasMorePhotos: Bool = false
    
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
            if roverPhotos.photos.count == 0 || roverPhotos.photos.count < 25 {
                self.hasMorePhotos = false
                self.page = 1
            } else {
                self.hasMorePhotos = true
                self.page += 1
            }
            success?(nil)
        }) { (error) in
            failure?(error)
        }
    }
    
    private func resetRequestIfNeeded(type: RoverPhotoCameraType, camera: RoverPhotoCamera) {
        if (type != self.selectedCameraType || camera != self.selectedCamera) ||  (type == self.selectedCameraType && camera == self.selectedCamera) {
            self.hasMorePhotos = false
            self.page = 1
            self.roverPhotos.removeAll()
        }
        
        self.selectedCamera = camera
        self.selectedCameraType = type
    }
}
