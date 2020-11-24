//
//  DetailViewController.swift
//  NasaList
//
//  Created by Felipe Bastos on 24/11/20.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var imgPhoto: UIImageView?
    @IBOutlet var svImage: UIScrollView?
    var imageURL: String?
    
    //-----------------------------------------------------------------------
    //    MARK: UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgPhoto?.sd_setImage(with: URL(string: imageURL ?? ""))

        svImage?.delegate = self
        svImage?.minimumZoomScale = 1.0
        svImage?.maximumZoomScale = 10.0
        
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    //-----------------------------------------------------------------------
    //    MARK: Custom methods
    //-----------------------------------------------------------------------
    
    func configUI() {
        
    }
    
    func loadUI() {
        
    }
    
    @IBAction func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgPhoto
    }
}
