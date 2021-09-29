//
//  AllPhotosViewModel.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import UIKit

protocol AllPhotosViewModelDelegate: ViewModelDelegate {
    func allPhotosViewModel(_ viewModel: AllPhotosViewModel, didLoadApodsFor indexes: [IndexPath])
    func allPhotosViewModel(_ viewModel: AllPhotosViewModel, didErrorOccurFor range: (Date, Date))
}

class AllPhotosViewModel {
    weak var delegate: AllPhotosViewModelDelegate?
    
    private var isRequestingData: Bool = false
    private var segments: ApodSegments
    
    private(set) var apods: [Apod] = [] {
        didSet {
            self.delegate?.updateView()
        }
    }
    
    var totalApods: Int {
        return segments.totalApods
    }
    
    init(segments: ApodSegments = ApodSegments()) {
        self.segments = segments
    }
    
    func loadApods() {
        guard !isRequestingData else {
            return
        }
        
        let dates = segments.nextChunk()
        
        isRequestingData = true
        ApodRepository.getApods(from: dates.first!, ultil: dates.last!) { [weak self] newApods in
            guard let self = self else { return }
            
            self.isRequestingData = false
            self.apods.append(contentsOf: newApods)
            
            if self.segments.currentPage > 1 {
                let indexes = self.indexesToReload(from: newApods)
                self.delegate?.allPhotosViewModel(self, didLoadApodsFor: indexes)
            } else {
                self.apods = newApods
            }
            
        } onFailure: { [weak self] error in
            debugPrint(error)
            guard let self = self else { return }
            
            self.isRequestingData = false
            self.delegate?.allPhotosViewModel(self, didErrorOccurFor: (dates.first!, dates.last!))
        }
    }
    
    private func indexesToReload(from loadedApods: [Apod]) -> [IndexPath] {
        let startIndex = apods.count - loadedApods.count
        let endIndex = startIndex + loadedApods.count
        
        return (startIndex..<endIndex).map { row in
            return IndexPath(row: row, section: 0)
        }
    }
    
    func apod(at indexPath: IndexPath) -> Apod {
        return apods[indexPath.row]
    }
}
