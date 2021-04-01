//
//  NasaCollectionViewCell.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 30/03/21.
//

import Foundation
import UIKit

class NasaCollectionViewCell: UICollectionViewCell {
    static let id = "nasaCustomCell"
    
    /// Referência da imageView
    private var nasaImageView : UIImageView?
    /// Cache de imagem.
    var cacheImageAPI : ImageCache?
    /// Referência do URLSessionDataTask
    private var dataTask : URLSessionDataTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.activityIndicator(show: true)
        
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.borderWidth = 1.0

        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        
        nasaImageView = UIImageView()
        nasaImageView?.contentMode = .scaleAspectFill
        
        if let imageView = nasaImageView {
            contentView.addSubview(imageView)
        }
        
    }
    
    /// "ViewdidLoad" da célula
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nasaImageView?.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        
    }
    
    /// Método responsável por baixar a imagem
    /// - Parameter url: URL da imagem.
    func getImage(from url: URL) {
        
        
         cacheImageAPI?.downloadImage(url: url) { (image) in
            DispatchQueue.main.async() { [weak self] in
                self?.nasaImageView?.image = image
                self?.activityIndicator(show: false)
            }
        }
        
    }
    
    /// Método para configurar a célula
    /// - Parameter url: URL  da imagem.
    func configure(with url: String){

            getImage(from: URL(string: url)!)
        
    }
    
    override func prepareForReuse() {
        self.nasaImageView?.image = nil
        self.activityIndicator(show: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
}
