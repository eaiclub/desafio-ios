//
//  ApodViewController.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import UIKit

class ApodViewController: UIViewController {

    private lazy var dummyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .galada(size: 24)
        label.textColor = .secondaryLabel
        label.text = "Apod"
        return label
    }()
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ApodViewController: ViewCode {
    func addTheme() {
        view.backgroundColor = .systemBackground
    }
    
    func addViews() {
        view.addSubview(dummyLabel)
    }
    
    func addConstraints() {
        dummyLabel.anchorToCenter(of: view)
    }
}
