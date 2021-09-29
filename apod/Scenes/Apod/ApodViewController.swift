//
//  ApodViewController.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import UIKit

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
    
    private lazy var containerView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [topBarView, UIView()])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    
    private var apod: Apod
    
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
        backLabel.text = navigationController?.previousViewController()?
            .title ?? "back"
        
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
        containerView.constrainTo(safeEdgesOf: view)
    }
}
