//
//  AllPhotosViewController.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import UIKit

protocol AllPhotosFlowCoordinatorDelegate: AnyObject {
    func allPhotosViewController(_ controller: UIViewController, didSelectCellFor apod: Apod)
}

class AllPhotosViewController: UIViewController {

    // MARK: - subviews
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = -ApodCell.LayoutProps.radius
        layout.itemSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.width * 1.5
        )
        layout.headerReferenceSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: AllPhotosHeaderView.LayoutProps.height
        )
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: collectionViewLayout)
        collectionView.register(ApodCell.self,
                                forCellWithReuseIdentifier: ApodCell.reuseId)
        collectionView.register(AllPhotosHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: AllPhotosHeaderView.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alpha = 0
        return collectionView
    }()
    
    private lazy var listSkeletonView: ApodListSkeleton = {
        let view = ApodListSkeleton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - properties
    var flowCoordinatorDelegate: AllPhotosFlowCoordinatorDelegate?
    
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
        title = "All Pictures"
        
        viewModel.delegate = self
        viewModel.loadApods()
    }
}

// MARK: - view code
extension AllPhotosViewController: ViewCode {
    func addTheme() {
        view.backgroundColor = .tertiarySystemBackground
    }
    
    func addViews() {
        view.addSubview(listSkeletonView)
    }
    
    func addConstraints() {
        listSkeletonView.constrainTo(edgesOf: view)
    }
    
    private func addApodsCollectionView() {
        view.addSubview(collectionView)
        collectionView.constrainTo(edgesOf: view)
    }
    
    private func revealApodsCollectionAnimating() {
        collectionView.reloadData()
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.collectionView.alpha = 1
        }
    }
}

// MARK: - view model
extension AllPhotosViewController: AllPhotosViewModelDelegate {
    func updateView() {
        listSkeletonView.stopLoading()
        
        addApodsCollectionView()
        revealApodsCollectionAnimating()
    }
    
    func allPhotosViewModel(_ viewModel: AllPhotosViewModel,
                            didLoadApodsFor indexes: [IndexPath]) {
        let indexesToReload = visibleIndexesToReload(intersecting: indexes)
        
        collectionView.reloadItems(at: indexesToReload)
    }
    
    func allPhotosViewModel(_ viewModel: AllPhotosViewModel, didErrorOccurFor range: (Date, Date)) {
        let startDate = DateFormatter.format(to: .monthDayYear, value: range.0)
        let endDate = DateFormatter.format(to: .monthDayYear, value: range.1)
        
        CustomTopAlert.show(
            message: "Something went wrong loading the photos of \(startDate) to \(endDate)",
            in: self
        )
    }
}

extension AllPhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let apod = viewModel.apods[indexPath.row]
        flowCoordinatorDelegate?.allPhotosViewController(self, didSelectCellFor: apod)
    }
}

extension AllPhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalApods
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApodCell.reuseId, for: indexPath) as? ApodCell else {
            fatalError("Provide an appropriate cell for post collection view")
        }
        
        if isLoadingCell(for: indexPath) {
            cell.setup(forPosition: indexPath.row)
        } else {
            cell.setup(with: viewModel.apod(at: indexPath), forPosition: indexPath.row)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AllPhotosHeaderView.reuseId, for: indexPath)
                    as? AllPhotosHeaderView else {
                fatalError("Invalid view type for the all photos header")
            }
            
            return headerView
            
        default:
            assert(false, "Invalid element type")
        }
    }
}

extension AllPhotosViewController: UICollectionViewDataSourcePrefetching {
    
    // verify if the cell for the index path is ahead of the current loaded apods
    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.apods.count
    }
    
    private func visibleIndexesToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = collectionView.indexPathsForVisibleItems
        
        let indexesIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        
        return Array(indexesIntersection)
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.loadApods()
        }
    }
}
