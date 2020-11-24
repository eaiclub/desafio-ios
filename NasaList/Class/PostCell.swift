//
//  PostCell.swift
//  NasaList
//
//  Created by Felipe Bastos on 19/11/20.
//

import UIKit
import SDWebImage

class PostCell: UITableViewCell, UIScrollViewDelegate, UIContextMenuInteractionDelegate {
    
    @IBOutlet var lblAuthor: UILabel?
    @IBOutlet var imgPhoto: UIImageView?
    @IBOutlet var lblTitle: UILabel?
    @IBOutlet var vwAuthor: UIView?
    @IBOutlet var lblDescription: UILabel?
    @IBOutlet var lblDate: UILabel?
    @IBOutlet var vwBackground: UIView?
    @IBOutlet var vwContent: UIView?
    
    @IBOutlet var svImage: UIScrollView?
    
    func loadUI(item: Post) {
        
        let interaction = UIContextMenuInteraction(delegate: self)
        vwContent?.addInteraction(interaction)
        
        svImage?.delegate = self
        svImage?.minimumZoomScale = 1.0
        svImage?.maximumZoomScale = 10.0
        
        lblAuthor?.text = item.author
        
        imgPhoto?.sd_setImage(with: URL(string: item.image ?? ""))
        lblTitle?.text = item.title
        lblDescription?.text = item.description
        lblDate?.text = item.date
        
        vwBackground?.layer.shadowColor = UIColor.black.cgColor
        vwBackground?.layer.shadowOffset = CGSize(width: 2, height: 2)
        vwBackground?.layer.shadowRadius = 4
        vwBackground?.layer.shadowOpacity = 0.3
        
        if item.author == nil {
            lblAuthor?.text = "Anonymous"
        }
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
            return self.makeContextMenu()
        })
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgPhoto
      }
    
    func makeContextMenu() -> UIMenu {
        let delete = UIAction(title: "Save Image", image: UIImage(systemName: "square.and.arrow.down.fill")) { action in
            if let image = self.imgPhoto?.image {
                ImageSaver().writeToPhotoAlbum(image: image)
            }
        }
        return UIMenu(title: "", children: [delete])
    }
}
