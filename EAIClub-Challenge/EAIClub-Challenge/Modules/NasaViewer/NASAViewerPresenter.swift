//  
//  NASAViewerPresenter.swift
//  EAIClub-Challenge
//
//  Created by Rhullian Damião on 26/12/20.
//

import Foundation
import UIKit

protocol NASAViewerPresenterDelegate: class {
  func nasaViewerPresenter(didGetNasaImageSuccessfully image: UIImage)
  func nasaViewerPresenter(didFailToGetNasaImage presenter: NASAViewerPresenter)
}

class NASAViewerPresenter {
  
  weak var delegate: NASAViewerPresenterDelegate?
  
  init(delegate: NASAViewerPresenterDelegate) {
    
    self.delegate = delegate
  }
  
  func didLoad() {
    getNasaImage()
  }
  
  func willAppear() {
  }
  
  func didAppear() {
  }
  
  private func getNasaImage() {
    WSNasaMedia.Endpoints.getSpaceImage.makeRequest { (response: NasaImageModel) in
      guard let urlString = response.url, let url = URL(string: urlString),
            let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
        self.delegate?.nasaViewerPresenter(didFailToGetNasaImage: self)
        return
      }
      self.delegate?.nasaViewerPresenter(didGetNasaImageSuccessfully: image)
    } failure: { (_) in
      self.delegate?.nasaViewerPresenter(didFailToGetNasaImage: self)
    }

  }
}
