//
//  ViewControllerViewModel.swift
//  Teste EAI
//
//  Created by Alexandre Furquim on 14/11/20.
//

import Foundation
import UIKit
import Kingfisher

class ViewControllerViewModel: NSObject {
    
    private var model = [PlanetaryModelResponse?]()
    private let service = EAIAPI()
    private var controllerDelegate: ViewControllerDelegate?
    private var parentController: ViewController
    var haveMoreData = true
    var isFetchingData = false
    var dateNow = Date()
    var dateFiltered = Date()
    let DATE_HIFEN_yyyyMMdd:String = "yyyy-MM-dd"
    
    
    // MARK: - Initialization
    public init(controllerDelegate: ViewControllerDelegate, parentController: ViewController) {
        self.controllerDelegate = controllerDelegate
        self.parentController = parentController
    }
    
    public func getPlanetary() {
        service.getPlanetary(dateSearch: stringFromDate(date: dateNow, stringFormat: DATE_HIFEN_yyyyMMdd), fullHD: false) { (response) in
            switch response {
            case .success(let gauge):
                self.model.append(gauge)
                self.parentController.requestSuccess()
            case .failure:
                print("error")
                self.parentController.requestFailure()
            }
        }
    }
    
    public func getMore() {
        let api = EAIAPI()
        
        if let dateLast = Calendar.current.date(byAdding: .day, value: -1, to: dateFiltered) {
            dateFiltered = dateLast
            api.getPlanetary(dateSearch: stringFromDate(date: dateFiltered, stringFormat: DATE_HIFEN_yyyyMMdd), fullHD: false) { (response) in
                switch response {
                case .success(let gauge):
                    self.model.append(gauge)
                    self.isFetchingData = false
                    self.parentController.requestSuccess()
                case .failure:
                    print("error")
                    self.isFetchingData = false
                    self.parentController.requestFailure()
                }
            }
        }
    }
    
    func stringFromDate(date:Date?, stringFormat:String!) -> String{
        
        if let d = date {
            
            let dateFormatter:DateFormatter = DateFormatter.init()
            let calendar:Calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
            let enUSPOSIXLocale:Locale = Locale.init(identifier: "en_US_POSIX")
            //
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.calendar = calendar
            dateFormatter.dateFormat = stringFormat
            dateFormatter.locale = enUSPOSIXLocale
            //
            let strDate:String = dateFormatter.string(from: d)
            //
            return strDate
        }else{
            return ""
        }
    }
    
    
    func shouldfetchNextData(collectionView: UICollectionView, indexPath: IndexPath) -> Bool {
        if self.isFetchingData || !self.haveMoreData {
            return false
        }
        
        // if not last section
        if self.numberOfSections(in: collectionView) != indexPath.section + 1 {
            return false
        }
        
        //        if indexPath.row >= self.collectionView(collectionView, numberOfItemsInSection: indexPath.section) - 1 {
        //            return true
        //        }
        
        
        // check if last row
        if collectionView.numberOfItems(inSection: indexPath.section) == indexPath.row + 1 {
            return true
        }
        
        return false
    }
    
    @objc open func fetchNextData () {
        isFetchingData = true
        getMore()
    }
}

extension ViewControllerViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected Cell #\(indexPath.row)")
    }
}

extension ViewControllerViewModel: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? StoryboardCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(item: model[indexPath.row]!)
                
        if shouldfetchNextData(collectionView: collectionView, indexPath: indexPath) {
            fetchNextData()
        }
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("Current centered index: \(String(describing: parentController.centeredCollectionViewFlowLayout.currentCenteredPage ?? nil))")
        if let index = parentController.centeredCollectionViewFlowLayout.currentCenteredPage {
            parentController.title = model[index]?.title
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("Current centered index: \(String(describing: parentController.centeredCollectionViewFlowLayout.currentCenteredPage ?? nil))")
    }
    
}
