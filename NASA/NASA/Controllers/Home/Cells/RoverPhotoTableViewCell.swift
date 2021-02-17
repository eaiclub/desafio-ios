//
//  RoverPhotoTableViewCell.swift
//  NASA
//
//  Created by Matheus Pacheco Fusco on 16/02/21.
//  Copyright © 2021 Matheus Pacheco Fusco. All rights reserved.
//

import UIKit
import Kingfisher

class RoverPhotoTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var roverImageView: UIImageView!
    @IBOutlet private weak var earthDateLabel: UILabel!
    @IBOutlet private weak var roverNameLabel: UILabel!
    @IBOutlet private weak var cameraNameLabel: UILabel!
    @IBOutlet private weak var roverStatusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    open func setRoverPhoto(_ photo: RoverPhoto) {
        self.earthDateLabel.text = photo.earthDate.toDate()?.toString()
        self.roverNameLabel.text = photo.rover.name
        self.cameraNameLabel.text = photo.camera.name
        self.roverStatusLabel.text = photo.rover.status
        
        guard photo.imgSrc != "", let url = URL(string: photo.imgSrc) else { return }
        self.roverImageView.kf.indicatorType = .activity
        
        let processor = DownsamplingImageProcessor(size: self.roverImageView.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 20)
        self.roverImageView.kf.setImage(with: url,
                                        placeholder: UIImage(named: "placeholderImage"),
                                        options: [
                                            .processor(processor),
                                            .transition(.fade(1)),
                                            .cacheOriginalImage])
    }
    
}
