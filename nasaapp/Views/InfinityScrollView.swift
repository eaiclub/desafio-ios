import Foundation
import UIKit

class InfinityScrollView: UIView {
    
    var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getCellHeight()-> CGFloat {
        var statusHeight: CGFloat!
        if #available(iOS 13.0, *) {
            statusHeight = self.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusHeight = UIApplication.shared.statusBarFrame.height
        }
        return self.bounds.height-statusHeight
    }
}

extension InfinityScrollView: RenderViewProtocol {
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    func additionalViewSetup() {
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = 80
        backgroundColor = .darkGray
    }
    
}

