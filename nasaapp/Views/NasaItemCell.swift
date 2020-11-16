import Foundation
import UIKit
import SDWebImage
import WebKit

protocol NasaItemCellDelegate {
    func showAlert(title: String, message: String)
}

class NasaItemCell: UITableViewCell {
    
    struct Constants {
        static let rightMargin : CGFloat = -16.0
        static let leftMargin : CGFloat = 16.0
    }
    
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let imageOfTheDayImgView = UIImageView()
    let copyrightLabel = UILabel()
    let activityIndicador = UIActivityIndicatorView()
    let seeExplanationBtn = UIButton()
    let webView = WKWebView()
    
    private var explationExpanded = String()
    
    var delegate : NasaItemCellDelegate?
    
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
        seeExplanationBtn.isHidden = true
        activityIndicador.isHidden = false
        activityIndicador.startAnimating()
    }
    
    func populateWithObject(item: NasaResponseItem) {
        titleLabel.isHidden = false
        dateLabel.isHidden = false
        imageOfTheDayImgView.isHidden = false
        copyrightLabel.isHidden = false
        seeExplanationBtn.isHidden = false
        activityIndicador.isHidden = true
        
        titleLabel.text = item.title
        dateLabel.text = item.date
        
        switch item.media_type {
        case "video":
            webView.isHidden = false
            let request = URLRequest(url: item.url)
            webView.load(request)
            break
        case "image":
            webView.isHidden = true
            if let hd = item.hdurl {
                imageOfTheDayImgView.sd_setImage(with: hd)
            } else {
                imageOfTheDayImgView.sd_setImage(with: item.url)
            }
            break
        default:
            //nada-faz
            break
        }
        
        if let copyright = item.copyright {
            copyrightLabel.isHidden = false
            copyrightLabel.text = "Copyright: \(copyright)"
        } else {
            copyrightLabel.isHidden = true
        }
        
        explationExpanded = item.explanation
    }
    
}

extension NasaItemCell: RenderViewProtocol {
    
    func buildViewHierarchy() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        imageOfTheDayImgView.translatesAutoresizingMaskIntoConstraints = false
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        seeExplanationBtn.translatesAutoresizingMaskIntoConstraints = false
        activityIndicador.translatesAutoresizingMaskIntoConstraints = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(imageOfTheDayImgView)
        addSubview(copyrightLabel)
        addSubview(seeExplanationBtn)
        addSubview(activityIndicador)
        addSubview(webView)
    }
    
    func setupConstraints() {
        activityIndicador.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        activityIndicador.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leftMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.rightMargin).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leftMargin).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.rightMargin).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        imageOfTheDayImgView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 0).isActive = true
        imageOfTheDayImgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leftMargin).isActive = true
        imageOfTheDayImgView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.rightMargin).isActive = true
        imageOfTheDayImgView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width*1.2).isActive = true
        
        webView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 0).isActive = true
        webView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leftMargin).isActive = true
        webView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.rightMargin).isActive = true
        webView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width*1.2).isActive = true
        
        copyrightLabel.topAnchor.constraint(equalTo: imageOfTheDayImgView.bottomAnchor, constant: 0).isActive = true
        copyrightLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leftMargin).isActive = true
        copyrightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.rightMargin).isActive = true
        copyrightLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        seeExplanationBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leftMargin).isActive = true
        seeExplanationBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.rightMargin).isActive = true
        seeExplanationBtn.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        seeExplanationBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func additionalViewSetup() {
        //titleLabel.backgroundColor = . gray
        titleLabel.textAlignment = .center
        
        //dateLabel.backgroundColor = .yellow
        dateLabel.textAlignment = .center
        
        imageOfTheDayImgView.contentMode = .scaleAspectFit
        imageOfTheDayImgView.clipsToBounds = true
        imageOfTheDayImgView.layer.cornerRadius = 5.0
        //imageOfTheDayImgView.backgroundColor = .blue
        
        //webView.backgroundColor = .brown
        
        copyrightLabel.textAlignment = .center
        //copyrightLabel.backgroundColor = .cyan
        
        seeExplanationBtn.backgroundColor = .systemBlue
        seeExplanationBtn.setTitle("Click to See Explanation", for: .normal)
        seeExplanationBtn.setTitleColor(.white, for: .normal)
        seeExplanationBtn.layer.cornerRadius = 5.0
        seeExplanationBtn.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
        
        contentView.isUserInteractionEnabled = false
        selectionStyle = .none
        //backgroundColor = .green
    }
    
    @objc func buttonClicked(sender: UIButton!) {
        if let title = titleLabel.text {
            self.delegate?.showAlert(title: title, message: explationExpanded)
        }
        
    }
    
}

