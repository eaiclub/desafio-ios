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
        
        
        let apiLoader = APILoader(apiRequest: request)
        let queryParameters : KeyValuePairs<Any,Any> = [
            APIKeys.API_KEY.rawValue: APIKeys.API_VALUE.rawValue,
            APIKeys.DATE_START_KEY.rawValue : self.dates.first!,
            APIKeys.DATE_END_KEY.rawValue : self.dates.last!
        ]
        apiLoader.loadAPIRequest(requestData: queryParameters) { (model, error) in
                if let error = error {
                    print(error)
                } else {
                    
                    model?.forEach({ (url) in
                        if url.url.contains("youtube"){
                            return
                        } else {
                        self.datasourceData.append(url.url)
                        }
                    })
                    
                    
                    self.readyToReload!()
                }
            }
        
    }
    
    
}
