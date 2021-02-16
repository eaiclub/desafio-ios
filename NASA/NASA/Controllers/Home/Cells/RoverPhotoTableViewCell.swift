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
    
    @IBOutlet weak var roverImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    open func setRoverPhoto(_ photo: RoverPhoto) {
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
