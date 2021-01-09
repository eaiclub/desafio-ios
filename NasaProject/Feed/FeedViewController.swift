//
//  FeedViewController.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 08/01/21.
//

import UIKit
import Alamofire

final class FeedViewController: UIViewController, SceneViewController {
    typealias T = FeedPresenter
    var presenter: FeedPresenter

    var coordinator: Coordinator

    init(coordinator: Coordinator, presenter: FeedPresenter) {
        self.coordinator = coordinator
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green

    }
}
