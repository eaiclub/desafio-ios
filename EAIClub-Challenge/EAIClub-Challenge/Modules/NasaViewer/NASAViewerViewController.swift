//  
//  NASAViewerViewController.swift
//  EAIClub-Challenge
//
//  Created by Rhullian Damião on 26/12/20.
//

import UIKit

class NASAViewerViewController: UIViewController {
  
  enum NASAViewerRouter {}
  
  // MARK: - UI
  private lazy var scrollView: UIScrollView = {
    let view = UIScrollView(frame: .zero)
    
    view.translatesAutoresizingMaskIntoConstraints = false
    view.minimumZoomScale = 2
    view.maximumZoomScale = 10
    view.delegate = self
    
    return view
  }()
  
  private lazy var activityIndicator: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView(style: .medium)
    
    view.hidesWhenStopped = true
    view.color = .white
    view.startAnimating()
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  // MARK: - Properties
  var presenter: NASAViewerPresenter!
  
  // MARK: - View Lifecycle
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupConfig()
    presenter.didLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.willAppear()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    presenter.didAppear()
  }
  
  // MARK: - Methods
  private func setupConfig() {
    self.presenter = NASAViewerPresenter(delegate: self)
    self.setupConstraints()
  }
  
  private func setupConstraints() {
    view.addSubview(activityIndicator)
    view.addSubview(scrollView)
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }
  
  private func setupScrollView(with image: UIImage, at position: CGPoint = CGPoint(x: 0, y: 0)) {
    let imgView = UIImageView(image: image)
    scrollView.addSubview(imgView)
    scrollView.contentSize = image.size
    imgView.frame.origin = position
  }
  
  // MARK: - Actions
  
}

// MARK: - NASAViewerPresenterDelegate
extension NASAViewerViewController: NASAViewerPresenterDelegate {
  func nasaViewerPresenter(didGetNasaImageSuccessfully image: UIImage) {
    setupScrollView(with: image)
  }
  
  func nasaViewerPresenter(didFailToGetNasaImage presenter: NASAViewerPresenter) {
    print("NO IMAGE TO SET!")
  }
}

extension NASAViewerViewController: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return self.scrollView.subviews.first
  }
}

// MARK: - ROUTER FUNCTIONS
extension NASAViewerViewController {
  func navigate(to selected: NASAViewerRouter) {
  }
}
