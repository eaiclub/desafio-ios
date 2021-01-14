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

    func failedToFetchNewItems(error: Error) {
        print(error)
        let alert = UIAlertController(title: "Erro", message: "Não foi possível buscar os dados", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Tentar novamente", style: .default, handler: { [weak self] _ in
            self?.presenter.fetchBodies()
        }))

        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { _ in }))

        present(alert, animated: true)
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

        let detailPresenter = presenter.getDetailPresenter(for: indexPath)
        transition(to: .detail(detailPresenter), type: .detail)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter.checkPagination(for: indexPath)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        getIndicatorView()
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
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = Color.background
        title = "Cosmos"

        tableView.register(type: CelestialBodyCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func getIndicatorView() -> UIView {
        let containerView = UIView()

        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()

        containerView.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40).isActive = true
        indicator.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -40).isActive = true
        indicator.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        indicator.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true

        return containerView
    }
}
