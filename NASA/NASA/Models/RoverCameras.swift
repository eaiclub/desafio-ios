//
//  RoverCameras.swift
//  NASA
//
//  Created by Matheus Pacheco Fusco on 13/02/21.
//  Copyright © 2021 Matheus Pacheco Fusco. All rights reserved.
//

import UIKit

struct RoverCameras {
    let types: [RoverPhotoCameraType] = [.curiosity, .opportunity, .spirit]
    let cameras: [RoverCameraType] = [RoverCameraType(abbreviation: .fhaz, type: [.curiosity, .opportunity, .spirit]),
                                      RoverCameraType(abbreviation: .rhaz, type: [.curiosity, .opportunity, .spirit]),
                                      RoverCameraType(abbreviation: .mast, type: [.curiosity]),
                                      RoverCameraType(abbreviation: .chemcam, type: [.curiosity]),
                                      RoverCameraType(abbreviation: .mahli, type: [.curiosity]),
                                      RoverCameraType(abbreviation: .mardi, type: [.curiosity]),
                                      RoverCameraType(abbreviation: .navcam, type: [.curiosity, .opportunity, .spirit]),
                                      RoverCameraType(abbreviation: .pancam, type: [.opportunity, .spirit]),
                                      RoverCameraType(abbreviation: .minites, type: [.opportunity, .spirit]),
                                      RoverCameraType(abbreviation: .all, type: [.curiosity, .opportunity, .spirit])]
    
    func camerasForType(_ type: RoverPhotoCameraType) -> [RoverCameraType] {
        return self.cameras.filter({ $0.type.contains(type) })
    }
}

struct RoverCameraType {
    var abbreviation: RoverPhotoCamera
    var type: [RoverPhotoCameraType]
}

enum RoverPhotoCamera: String {
    case fhaz = "FHAZ"
    case rhaz = "RHAZ"
    case mast = "MAST"
    case chemcam = "CHEMCAM"
    case mahli = "MAHLI"
    case mardi = "MARDI"
    case navcam = "NAVCAM"
    case pancam = "PANCAM"
    case minites = "MINITES"
    case all = "All Cameras"
    
    var descr: String {
        switch self {
        case .fhaz:
            return "Front Hazard Avoidance Camera"
        case .rhaz:
            return "Rear Hazard Avoidance Camera"
        case .mast:
            return "Mast Camera"
        case .chemcam:
            return "Chemistry and Camera Complex"
        case .mahli:
            return "Mars Hand Lens Imager"
        case .mardi:
            return "Mars Descent Imager"
        case .navcam:
            return "Navigation Camera"
        case .pancam:
            return "Panoramic Camera"
        case .minites:
            return "Miniature Thermal Emission Spectrometer (Mini-TES)"
        case .all:
            return ""
        }
    }
}

enum RoverPhotoCameraType: String {
    case curiosity = "curiosity"
    case opportunity = "opportunity"
    case spirit = "spirit"
}
