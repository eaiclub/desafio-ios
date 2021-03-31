//
//  ViewModel.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 30/03/21.
//

import Foundation


class ViewModel {
    
    var imgCache = ImageCache()
    
    let request = NasaAPI()
    
    
    var datasourceData: [String] = []
    
    var dates : [String] = []
    
    init() {
        
    }
    
    
}
