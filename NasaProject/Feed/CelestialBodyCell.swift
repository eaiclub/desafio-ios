//
//  CelestialBodyCell.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 10/01/21.
//

import UIKit
import Alamofire
import AlamofireImage

final class CelestialBodyCell: UITableViewCell {

    private let dateLabel = UILabel()
    private let bodyImageView = UIImageView()
    private let titleLabel = UILabel()

    private lazy var stackView = UIStackView(arrangedSubviews: [dateLabel, bodyImageView, titleLabel])

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with body: CelestialBody) {
        dateLabel.text = body.date
        titleLabel.text = body.title

        bodyImageView.backgroundColor = .lightGray
        bodyImageView.image = nil

        guard let url = URL(string: body.url) else { return }

        bodyImageView.af.setImage(withURL: url, cacheKey: body.url, completion: { response in
            switch response.result {
            case .success:
                break
            case .failure(let error):
                print(error)
            }
        })
    }
}

extension CelestialBodyCell: ViewConfigurator {
    func buildViewHierarchy() {
        addSubview(stackView)
    }

    func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true

        bodyImageView.translatesAutoresizingMaskIntoConstraints = false
        bodyImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

    func configureViews() {
        stackView.axis = .vertical
        stackView.spacing = 10

        bodyImageView.contentMode = .scaleAspectFill
        bodyImageView.clipsToBounds = true
    }
}
