//
//  AllPhotosDataSource.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import UIKit

class AllPhotosDataSource: NSObject, UICollectionViewDataSource {
    
    private var items: [Post]
    
    init(items: [Post]) {
        self.items = items
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.reuseId, for: indexPath) as? PostCell else {
            fatalError("Provide an appropriate cell for post collection view")
        }
        
        let post = items[indexPath.row]
        
        cell.setup(with: post, forPosition: indexPath.row)
        return cell
    }

}
