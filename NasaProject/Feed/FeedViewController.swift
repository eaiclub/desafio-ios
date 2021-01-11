//
//  FeedViewController.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 08/01/21.
//

import UIKit
import Alamofire

protocol FeedViewProtocol: NSObject {
    func reload(indexes: [IndexPath])
}

final class FeedViewController: UIViewController, SceneViewController {
    typealias T = FeedPresenter
    var presenter: FeedPresenter
    var coordinator: Coordinator

    private let tableView = UITableView()

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
        setupViewConfiguration()
        presenter.fetchBodies()
    }
}

extension FeedViewController: FeedViewProtocol {
    func reload(indexes: [IndexPath]) {
        tableView.insertRows(at: indexes, with: .automatic)
    }
}

extension FeedViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, of: CelestialBodyCell.self)
        cell.setup(with: presenter.item(for: indexPath.row))
        return cell
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FeedViewController: ViewConfigurator {
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }

    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func configureViews() {
        title = "Cosmos"
        navigationController?.navigationBar.prefersLargeTitles = true

        tableView.register(type: CelestialBodyCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
}
