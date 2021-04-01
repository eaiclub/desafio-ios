//
//  ViewController.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 29/03/21.
//

import UIKit

class ViewController: UIViewController {

    var nasaCollectionView : UICollectionView?
    var fakeValue = 10
    var isAble = false
    var viewModel : ViewModel?
    var alert = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = ViewModel()
        configureUIElements()
        
        viewModel?.readyToReload = { error in
            
            if error == nil {
                DispatchQueue.main.async {
                    self.nasaCollectionView?.reloadData()
                    self.isAble.toggle()
                }
            } else {
                let error = error as! ServiceError
                self.alert = UIAlertController(title: "ERROR \(error.httpStatus)", message: error.message, preferredStyle: .alert)
                self.alert.message = error.message
                self.alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(self.alert, animated: true)
                
                
            }
            
        }
        
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
        
        nasaCollectionView?.register(NasaFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: NasaFooterView.id)
        
        self.view.addSubview(nasaCollectionView!)
        
        
    }
    
    
    
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.datasourceData.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NasaCollectionViewCell.id, for: indexPath) as! NasaCollectionViewCell
        cell.cacheImageAPI = viewModel?.imgCache
        cell.configure(with: viewModel?.datasourceData[indexPath.row] ?? "nill")
        return cell
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offSetY > contentHeight - scrollView.frame.height && isAble  {
            
            viewModel?.fetchMoreData()
            self.isAble.toggle()
            
        }
        
        
        
    }
        
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let datasource = viewModel?.datasourceData{
            viewModel?.imgCache.cancelRequest(with: datasource[indexPath.row])
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {

        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NasaFooterView.id, for: indexPath)
            return footerView

        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.nasaCollectionView?.contentSize.width ?? 60, height: 60.0)
    }
    
}


extension ViewController: UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellWidth : CGFloat = self.view.frame.size.width/2 - 15
        let cellheight : CGFloat = self.view.frame.size.width/2 - 15

        return CGSize(width: cellWidth , height:  cellheight)
    }
}


protocol SetupViewCoding{
    func configureUIElements()
}
