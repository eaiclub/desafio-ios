//
//  HomePresenter.swift
//  NASA
//
//  Created by Matheus Pacheco Fusco on 14/02/21.
//  Copyright © 2021 Matheus Pacheco Fusco. All rights reserved.
//

import UIKit

class HomePresenter: NSObject {
    let roverCameras = RoverCameras()
    open var selectedCamera: RoverPhotoCamera = .fhaz
    open var selectedCameraType: RoverPhotoCameraType = .curiosity
    
    func getPictureOfTheDay() {
        APODService().getPictureOfTheDay(success: { result in
            guard let apod = result as? APOD else {
                print("erro)")
                return
            }
            print(apod)
        }) { (error) in
            print("erro - \(error.debugDescription)")
        }
    }
    
    func getRoversPhotos() {
        RoverPhotosService().getRoversPhotos(type: selectedCameraType, camera: selectedCamera, success: { (result) in
            guard let roverPhotos = result as? RoverPhotos else {
                print("erro)")
                return
            }
            print(roverPhotos)
        }) { (error) in
            print("erro - \(error.debugDescription)")
        }
    }
}
