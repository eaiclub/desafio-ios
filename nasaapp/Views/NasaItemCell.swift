import Foundation
import UIKit
import SDWebImage

class NasaItemCell: UITableViewCell {
    
    struct Constants {
        static let rightMargin : CGFloat = -16.0
        static let leftMargin : CGFloat = 16.0
    }
    
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let imageOfTheDayImgView = UIImageView()
    let copyrightLabel = UILabel()
    let explanationLabel = UILabel()
    let activityIndicador = UIActivityIndicatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageOfTheDayImgView.image = nil
        imageOfTheDayImgView.setNeedsDisplay()
        setNeedsDisplay()
    }
    
    func populateWithNoData() {
        titleLabel.isHidden = true
        dateLabel.isHidden = true
        imageOfTheDayImgView.isHidden = true
        copyrightLabel.isHidden = true
        explanationLabel.isHidden = true
        activityIndicador.isHidden = false
        activityIndicador.startAnimating()
    }
    
    func populateWithObject(item: NasaResponseItem) {
        titleLabel.isHidden = false
        dateLabel.isHidden = false
        imageOfTheDayImgView.isHidden = false
        copyrightLabel.isHidden = false
        explanationLabel.isHidden = false
        activityIndicador.isHidden = true
        
        titleLabel.text = item.title
        dateLabel.text = item.date
        
        if let hd = item.hdurl {
            imageOfTheDayImgView.sd_setImage(with: hd)
        } else {
            imageOfTheDayImgView.sd_setImage(with: item.url)
        }
        
        if let copyright = item.copyright {
            copyrightLabel.isHidden = false
            copyrightLabel.text = "Copyright: \(copyright)"
        } else {
            copyrightLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
            copyrightLabel.isHidden = true
        }
        
        explanationLabel.text = "Explanation: \(item.explanation)"
    }
    
}

extension NasaItemCell: RenderViewProtocol {
    
    func buildViewHierarchy() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        imageOfTheDayImgView.translatesAutoresizingMaskIntoConstraints = false
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        explanationLabel.translatesAutoresizingMaskIntoConstraints = false
        activityIndicador.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(imageOfTheDayImgView)
        addSubview(copyrightLabel)
        addSubview(explanationLabel)
        addSubview(activityIndicador)
    }
    
    func setupConstraints() {
        activityIndicador.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        activityIndicador.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leftMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.rightMargin).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leftMargin).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.rightMargin).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        imageOfTheDayImgView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16).isActive = true
        imageOfTheDayImgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leftMargin).isActive = true
        imageOfTheDayImgView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.rightMargin).isActive = true
        imageOfTheDayImgView.bottomAnchor.constraint(equalTo: copyrightLabel.topAnchor, constant: -16).isActive = true
        
        copyrightLabel.topAnchor.constraint(equalTo: imageOfTheDayImgView.bottomAnchor, constant: 0).isActive = true
        copyrightLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leftMargin).isActive = true
        copyrightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.rightMargin).isActive = true
        copyrightLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        explanationLabel.topAnchor.constraint(equalTo: copyrightLabel.bottomAnchor, constant: 0).isActive = true
        explanationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leftMargin).isActive = true
        explanationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.rightMargin).isActive = true
        explanationLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    func additionalViewSetup() {
        titleLabel.backgroundColor = . gray
        titleLabel.textAlignment = .center
        
        dateLabel.backgroundColor = .yellow
        dateLabel.textAlignment = .center
        
        imageOfTheDayImgView.contentMode = .scaleAspectFill
        imageOfTheDayImgView.clipsToBounds = true
        imageOfTheDayImgView.layer.cornerRadius = 10.0
        imageOfTheDayImgView.backgroundColor = .blue
        
        copyrightLabel.textAlignment = .center
        copyrightLabel.backgroundColor = .cyan
        
        explanationLabel.numberOfLines = 0
        explanationLabel.backgroundColor = .red
        
        selectionStyle = .none
        backgroundColor = .white
    }
    
}

