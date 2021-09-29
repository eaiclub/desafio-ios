//
//  ApodViewController.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import UIKit

protocol ApodFlowCoordinatorDelegate: AnyObject {
    func apodViewController(_ controller: ApodViewController, didPressBackButton sender: UIButton)
}

class ApodViewController: UIViewController {

    // MARK: - subviews
    private lazy var backButton: UIButton = {
        let image = UIImage(systemName: "arrow.backward")?
            .withRenderingMode(.alwaysTemplate)
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.tintColor = .label
        button.setImage(image, for: .normal)
        button.contentMode = .center
        return button
    }()
    
    private lazy var backLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.font = .openSans(.bold ,size: 14)
        label.textColor = .label
        return label
    }()
    
    private lazy var topBarView: UIView = {
        let view = UIStackView(arrangedSubviews: [ backButton, backLabel ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 8
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        return view
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(size: 14)
        label.textColor = .label
        return label
    }()
    
    private lazy var authorWrapperView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [authorLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        return view
    }()
    
    private lazy var apodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .tertiaryLabel.withAlphaComponent(0.5)
        imageView.layer.masksToBounds = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: 20)
        label.textColor = .label
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var explanationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(size: 14)
        label.textColor = .label
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var titlesWrapperView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            titleLabel,
            explanationLabel
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 20
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        return view
    }()
    
    private lazy var contentContainerView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            authorWrapperView,
            apodImageView,
            titlesWrapperView
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 20
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentContainerView)
        return view
    }()
    
    private lazy var containerView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [topBarView, scrollView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    
    // MARK: - properties
    var flowCoordinatorDelegate: ApodFlowCoordinatorDelegate?
    
    private var apod: Apod
    
    private var imageHeightConstraint: NSLayoutConstraint?
    
    // MARK: - view lifecycle
    init(presenting apod: Apod) {
        self.apod = apod
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
        backButton.addTarget(self,
                             action: #selector(backButtonPressed(_:)),
                             for: .touchUpInside)
        
        updateView()
    }

    @objc private func backButtonPressed(_ sender: UIButton) {
        flowCoordinatorDelegate?.apodViewController(self, didPressBackButton: sender)
    }
    
    private func updateView() {
        backLabel.text = navigationController?.previousViewController()?
            .title ?? "back"
        
        let copyrightInfo = apod.author != nil ? apod.author! : "unknown owner"
        authorLabel.text = "by \(copyrightInfo) ©"
        
        setupImage()
        
        titleLabel.text = apod.title
        explanationLabel.text = apod.explanation
    }
    
    private func setupImage() {
        guard let url = Apod.MediaType.resourceLocation(for: apod) else {
            return
        }
        
        apodImageView.af.setImage(withURL: url, completion: { [weak self] response in
            switch response.result {
            case .success(let image):
                let height = UIScreen.main.bounds.width * image.size.height / image.size.width
                
                self?.imageHeightConstraint?.constant = height
                self?.view.layoutIfNeeded()

            case .failure(let error):
                debugPrint("Could not possible to load image", error)
            }
        })
    }
}

extension ApodViewController: ViewCode {
    func addTheme() {
        view.backgroundColor = .systemBackground
    }
    
    func addViews() {
        view.addSubview(containerView)
    }
    
    func addConstraints() {
        containerView.constrainTo(edgesOf: view)
        
        contentContainerView.constrainToTopAndSides(of: scrollView)
        let bottomConstraint = contentContainerView.constrainToBottom(of: scrollView)
        bottomConstraint.priority = .defaultLow
                
        contentContainerView.anchorToCenterX(of: scrollView)
        let centerYConstraint = contentContainerView.anchorToCenterY(of: scrollView)
        centerYConstraint.priority = .defaultLow
        
        imageHeightConstraint = apodImageView
            .constrainHeight(to: UIScreen.main.bounds.width)
    }
}
