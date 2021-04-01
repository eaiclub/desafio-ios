//
//  ViewModel.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 30/03/21.
//

import Foundation


class ViewModel {
    
    /// Variável com referência do Cache de imagens.
    lazy var imgCache = ImageCache()
    
    /// Variável com referência do request handler da nasa.
    private let nasaRequestAPI = NasaRequestHandler()
    
    /// Variável com referência da classe responsável por fazer o DayTracker.
    private let tracker = DayTracker()
    
    /// Closure para atualizar a CollectionView
    var readyToReload : ((Error?) -> Void)?
    
    /// Array com url's das imagens a serem baixadas
    var datasourceData: [String] = []
    
    /// Array com range entre datas para fazer a busca.
    private var dates : [String] = []
    
    
    init() {
        dates = tracker.getDateParamenter(statingDate: Date().getFormattedDate(), lowerBound: 30)
        getAPIData()
    }
    
    /// Método responsável por atualizar o array de datas e buscar mais dados na API.
    func fetchMoreData(){
        dates.removeLast()
        dates = tracker.getDateParamenter(statingDate: dates.first ?? "nil", lowerBound: 30)
        getAPIData()

    }
    
    /// Método responsável por fazer a requisição na API.
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
