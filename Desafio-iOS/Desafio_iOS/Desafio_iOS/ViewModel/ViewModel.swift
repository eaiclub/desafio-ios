//
//  ViewModel.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 30/03/21.
//

import Foundation


class ViewModel {
    
    lazy var imgCache = ImageCache()
    private let nasaRequestAPI = NasaRequestHandler()
    private let tracker = DayTracker()
    var readyToReload : ((Error?) -> Void)?
    
    var datasourceData: [String] = []
    private var dates : [String] = []
    
    
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
    
        
        nasaRequestAPI.fetchNasaData(with: dates) { (urlArray, error) in
            
            
            if error == nil {
                
                urlArray?.forEach { (item) in
                    self.datasourceData.append(item)
                }
                    self.readyToReload!(nil)
                
            } else {
                
                self.readyToReload!(error)
                
            }
            
            
            
        }
        
    }
    
    
}
