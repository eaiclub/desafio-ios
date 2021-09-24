//
//  AllPhotosViewModel.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import UIKit

class AllPhotosViewModel: ViewModel {
    weak var delegate: ViewModelDelegate?

    private(set) var posts: [Post] = [] {
        didSet {
            self.delegate?.updateView()
        }
    }
    
    private var pager = PostsSegmentManager()
    
    init() {
        self.posts = pager.nextChunk()
    }
}
