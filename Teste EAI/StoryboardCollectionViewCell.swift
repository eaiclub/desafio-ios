//
//  StoryboardCollectionViewCell.swift
//  Teste EAI
//
//  Created by Alexandre Furquim on 14/11/20.
//

import Foundation
import UIKit
import WebKit

class StoryboardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explanationLabel: UITextView!
    @IBOutlet weak var planetaryImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var videoPlayer: WKWebView!
    
    private var viewModel: PlanetaryModelResponse!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
        
    public func configureCell(item: PlanetaryModelResponse) {
        self.viewModel = item
        setupUI()
    }
    
    func setupUI() {
                
        scrollView.maximumZoomScale = 4
        scrollView.minimumZoomScale = 1
        
        scrollView.delegate = self
        
        titleLabel.text = viewModel.title
        explanationLabel.text = viewModel.explanation
        
        scrollView.isHidden = true
        videoPlayer.isHidden = true
        
        switch viewModel.mediaType {
        case .image:
            let url = URL(string: viewModel.url!)
            planetaryImageView.kf.setImage(with: url)
            scrollView.isHidden = false
        case .video:
            if let url = viewModel.url, let myURL = URL(string: url) {
                let youtubeRequest = URLRequest(url: myURL)
                videoPlayer.load(youtubeRequest)
            }
            videoPlayer.isHidden = false
        default:
            print("default")
        }
    }
}

extension StoryboardCollectionViewCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return planetaryImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = planetaryImageView.image {
                let ratioW = planetaryImageView.frame.width / image.size.width
                let ratioH = planetaryImageView.frame.height / image.size.height
                
                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                let conditionLeft = newWidth*scrollView.zoomScale > planetaryImageView.frame.width
                let left = 0.5 * (conditionLeft ? newWidth - planetaryImageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                let conditioTop = newHeight*scrollView.zoomScale > planetaryImageView.frame.height
                
                let top = 0.5 * (conditioTop ? newHeight - planetaryImageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
                
            }
        } else {
            scrollView.contentInset = .zero
        }
    }
}
