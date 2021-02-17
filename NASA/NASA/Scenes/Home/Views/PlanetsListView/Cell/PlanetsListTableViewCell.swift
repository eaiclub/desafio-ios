//
//  PlanetsListTableViewCell.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 10/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import UIKit

public typealias Action = () -> Void

class PlanetsListTableViewCell: UITableViewCell {

    @IBOutlet private weak var planetariumImageView: UIImageView!
    @IBOutlet private weak var titleLabel          : UILabel!
    @IBOutlet private weak var dateLabel           : UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareLayout()
    }
    
    private func prepareLayout() {
        self.planetariumImageView.roundCorners(corners: [.topLeft, .topRight], radius: 8)
    }
    
    open func set(_ item: PlanetariumModel) {
        self.planetariumImageView.loadImage(withUrl: item.url ?? "", contentMode: .scaleToFill)
        self.titleLabel.text = item.title
        self.dateLabel.text = item.date?.toDate(format: "yyyy-MM-dd")?.toString(dateFormat: "dd/MM/yyyy")
    }
    
}
