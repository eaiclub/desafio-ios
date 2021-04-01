//
//  FooterNasaView.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 31/03/21.
//

import Foundation
import UIKit

class NasaFooterView: UICollectionReusableView {
    
    static let id = "nasaFooter"

 override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.white
    
    self.activityIndicator(show: true)

 }

 required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

 }
}
