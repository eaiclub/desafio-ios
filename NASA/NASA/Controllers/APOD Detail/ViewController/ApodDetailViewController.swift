//
//  ApodDetailViewController.swift
//  NASA
//
//  Created by Matheus Pacheco Fusco on 17/02/21.
//  Copyright © 2021 Matheus Pacheco Fusco. All rights reserved.
//

import UIKit
import Kingfisher
import youtube_ios_player_helper

class ApodDetailViewController: UIViewController {
    
    var apod: APOD?
    
    @IBOutlet private weak var apodView: UIView!
    @IBOutlet private weak var apodImageView: UIImageView!
    @IBOutlet private weak var apodTitleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var explanationTextView: UITextView!
    
    init(apod: APOD) {
        self.apod = apod
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Astronomy Picture of the Day"
        self.setupApodDetail()
    }
    
    private func setupApodDetail() {
        guard let apod = self.apod else { return }
        if let hdUrl = apod.hdUrl, let url = URL(string: hdUrl) {
            self.apodImageView.isHidden = false
            self.apodImageView.kf.indicatorType = .activity
//            let processor = DownsamplingImageProcessor(size: self.apodImageView.bounds.size)
//                |> RoundCornerImageProcessor(cornerRadius: 20)
            self.apodImageView.kf.setImage(
                with: url,
                options: [
//                    .processor(processor),
                    //                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
            ])
        } else {
            let ytId = apod.url.components(separatedBy: "https://www.youtube.com/embed/")[1]
            let playerView = YTPlayerView(frame: self.apodView.bounds)
            playerView.load(withVideoId: ytId)
            self.apodView.addSubview(playerView)
        }
        
        self.apodTitleLabel.text = apod.title
        self.dateLabel.text = apod.date.toDate()?.toString()
        self.explanationTextView.text = apod.explanation
    }
    
}
