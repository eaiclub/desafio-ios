//
//  AllPhotosViewController.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import UIKit

class AllPhotosViewController: UIViewController {

    // MARK: - subviews
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = -PostCell.LayoutProps.radius
        layout.itemSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.width
        )
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: collectionViewLayout)
        collectionView.register(PostCell.self,
                                forCellWithReuseIdentifier: PostCell.reuseId)
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - properties
    private var viewModel: AllPhotosViewModel
    
    // MARK: - view lifecycle
    init(viewModel: AllPhotosViewModel = AllPhotosViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }

}

// MARK: - view code
extension AllPhotosViewController: ViewCode {
    func addTheme() {
        view.backgroundColor = .systemBackground
    }
    
    func addViews() {
        view.addSubview(collectionView)
    }
    
    func addConstraints() {
        collectionView.constrainTo(edgesOf: view)
    }
}

// MARK: - view model
extension AllPhotosViewController: ViewModelDelegate {
    func updateView() {
        collectionView.reloadData()
    }
}

// MARK: - data source
extension AllPhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.reuseId, for: indexPath) as? PostCell else {
            fatalError("Provide an appropriate cell for post collection view")
        }
        
        let color = viewModel.colors[indexPath.row]
        
        cell.setup(with: color, forPosition: indexPath.row)
        return cell
    }
}