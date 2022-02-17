//
//  ApodRepository.swift
//  apod
//
//  Created by rafael.rollo on 24/09/21.
//

import Foundation

class ApodRepository {
    
    static func getApods(from date: Date,
                         ultil pastDate: Date,
                         onCompletion: @escaping ([Apod]) -> Void,
                         onFailure: @escaping (Error) -> Void) {
        
        APIRequest.execute(resource: .apods(pastDate, date)) { (apods: [Apod]) in
            onCompletion(apods.reversed())
            
        } onFailure: { error in
            onFailure(error)
        }
    }
}
