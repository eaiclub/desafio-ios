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

    private lazy var stackView = UIStackView(arrangedSubviews: [dateLabel, titleLabel, bodyImageView])

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

        bodyImageView.image = nil

        if !body.isVideo {
            setup(imageURL: body.url)
        } else if let thumbnail = body.thumbnail {
            setup(imageURL: thumbnail)
        } else {
            bodyImageView.isHidden = true
        }
    }

    private func setup(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }

        bodyImageView.isHidden = false

        bodyImageView.af.setImage(withURL: url, cacheKey: imageURL)
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
        bodyImageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
    }

    func configureViews() {
        stackView.axis = .vertical
        stackView.spacing = 10

        bodyImageView.contentMode = .scaleAspectFill
        bodyImageView.clipsToBounds = true
        bodyImageView.layer.cornerRadius = 8
        bodyImageView.backgroundColor = .lightGray

        dateLabel.font = .systemFont(ofSize: 17, weight: .bold)
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
    }
}
