//
//  ViewModel.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 30/03/21.
//

import Foundation


class ViewModel {
    
    var imgCache = ImageCache()
    
    let nasaRequestAPI = NasaRequestHandler()
    
    let tracker = DayTracker()
    
    var readyToReload : (() -> Void)?
    
    var datasourceData: [String] = []
    
    var dates : [String] = []
    
    init() {
        dates = tracker.getDateParamenter(statingDate: Date().getFormattedDate(), lowerBound: 30)
        getAPIData()
    }
    
    func fetchMoreData(){
        dates.removeLast()
        dates = tracker.getDateParamenter(statingDate: dates.first ?? "nil", lowerBound: 30)
        getAPIData()

    }
    
    func getAPIData(){
    
        
        nasaRequestAPI.fetchNasaData(with: dates) { (urlArray) in
            
            urlArray.forEach { (item) in
                self.datasourceData.append(item)
            }
                self.readyToReload!()
        }
        
    }
    
    
}
