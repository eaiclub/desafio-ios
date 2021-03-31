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
    
    private var nasaImageView : UIImageView?
    var cacheImageAPI : ImageCache?
    private var dataTask : URLSessionDataTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nasaImageView?.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        
    }
    
    func getImage(from url: URL) {
        
        
         cacheImageAPI?.downloadImage(url: url) { (image) in
            DispatchQueue.main.async() { [weak self] in
                self?.nasaImageView?.image = image
            }
        }
        
    }
    
    func configure(with url: String){

            getImage(from: URL(string: url)!)
        
    }
    
    override func prepareForReuse() {
        self.nasaImageView?.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
}
