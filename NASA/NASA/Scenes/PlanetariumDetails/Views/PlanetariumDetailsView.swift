//
//  PlanetariumDetailsView.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 12/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import UIKit

class PlanetariumDetailsView: UIView {

    @IBOutlet private weak var planetariumImageView: UIImageView!
    @IBOutlet private weak var planetariumLabel    : UILabel!
    @IBOutlet private weak var dateLabel           : UILabel!
    @IBOutlet private weak var descriptionLabel    : UILabel!
    
    private var observable : NSKeyValueObservation? = nil
    
    init() {
        super.init(frame: .zero)
        self.xib()
        self.prepareLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.xib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareLayout()
    }
    
    private func prepareLayout() {

        
    }
    
    open func set(_ item: PlanetariumModel? = nil) {
        self.planetariumImageView.loadImage(withUrl: item?.url ?? "")
        self.planetariumLabel.text = item?.title
        self.dateLabel.text = item?.date?.toDate(format: "yyyy-MM-dd")?.toString(dateFormat: "dd/MM/yyyy")
        self.descriptionLabel.text = "Descrição: \(item?.explanation ?? "")"
    }
}
