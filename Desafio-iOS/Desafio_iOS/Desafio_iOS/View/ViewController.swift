//
//  ViewController.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 29/03/21.
//

import UIKit


protocol SetupViewCoding{
    func configureUIElements()
}

class ViewController: UIViewController {

    var nasaCollectionView : UICollectionView?
    var fakeValue = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureUIElements()

        
    }


}

extension ViewController: SetupViewCoding{
    func configureUIElements() {
        
        
        
        nasaCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: UICollectionViewLayout())
        
        
        let cellW = nasaCollectionView?.frame.size.width ?? 60/2.0
        let cellH = nasaCollectionView?.frame.size.height ?? 60 - 2.0
        let cellSize = CGSize(width: cellW, height: cellH)
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        nasaCollectionView?.setCollectionViewLayout(layout, animated: true)
        nasaCollectionView?.backgroundColor = .white
        nasaCollectionView?.register(NasaCollectionViewCell.self, forCellWithReuseIdentifier: NasaCollectionViewCell.id)
        nasaCollectionView?.delegate = self
        nasaCollectionView?.dataSource = self
        
        self.view.addSubview(nasaCollectionView!)
        
    }
    
    
    
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fakeValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NasaCollectionViewCell.id, for: indexPath) as! NasaCollectionViewCell
        return cell
        
        
    }
    

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.nasaCollectionView?.contentSize.width ?? 60, height: 60.0)
    }
    
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offSetY > contentHeight - scrollView.frame.height {
            self.fakeValue += 10
            self.nasaCollectionView?.reloadData()
            
        }
        
        
        
    }
        
    
    
    
}


extension ViewController: UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellWidth : CGFloat = self.view.frame.size.width/2 - 15
        let cellheight : CGFloat = self.view.frame.size.width/2 - 15

        return CGSize(width: cellWidth , height:  cellheight)
    }
}
