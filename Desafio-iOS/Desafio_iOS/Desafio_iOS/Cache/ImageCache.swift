//
//  ImageCache.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 30/03/21.
//

import Foundation
import UIKit

class ImageCache{
    
    
    /// Dicionário que representa o Cache de imagens.
    var imgCache = NSCache<NSString,UIImage>()
    
    /// Variável para ter a referência da URLSessionDataTask
    private var dataTask : URLSessionDataTask?
    
    /// Dicionário com o array das requests sendo feitas.
    private var currentRequest : [String:URLSessionDataTask] = [:]
    
    /// Método responsável por baixar a imagem
    /// - Parameters:
    ///   - url: URL da imagem
    ///   - completion: Callback com a imagem baixada.
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void){
        
        if let cachedImage = imgCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
            
        } else {
            
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 0)
            dataTask = URLSession.shared.dataTask(with: request) {  [weak self] data, response, error  in
                
                defer{
                    self!.currentRequest.removeValue(forKey: request.url!.absoluteString)
                }
                
                guard error == nil, data != nil else {
                    return
                }
                
                guard let image = UIImage(data: data!) else { return }
                
                self!.imgCache.setObject(image, forKey: url.absoluteString as NSString)
                print("SALVOU A IMG: \(url.absoluteString)")
                
                DispatchQueue.main.async {
                    completion(image)
                }
                
            }
            dataTask?.resume()
            currentRequest[url.absoluteString] = dataTask
        }
    }
    
    /// Método responsável por cancelar a request.
    /// - Parameter url: Chave para cancelar a requisição.
    func cancelRequest(with url: String){
        
        if let task = currentRequest[url]{
            task.cancel()
        }
        
    }
    
    
    
}

