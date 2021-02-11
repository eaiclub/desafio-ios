//
//  LayoutVerticalViewController.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 10/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import UIKit

protocol LinearLayoutControllerProtocol {
    func add(view : UIView)
}

class LayoutVerticalViewController: UIViewController, LinearLayoutControllerProtocol {
    
    private var scrollView: UIScrollView = UIScrollView()
    private var stackView : UIStackView = UIStackView()
    
    var offset : UIEdgeInsets = .zero
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareLayout()
    }
    
    private func prepareLayout() {
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.bounces  = true
        self.scrollView.showsVerticalScrollIndicator     = false
        self.scrollView.showsHorizontalScrollIndicator   = false
        self.scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.alignment = .fill
        self.stackView.axis      = .vertical
        self.stackView.spacing   = 16
        self.stackView.distribution = .fill
        self.stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(stackView)
        self.scrollView.clipsToBounds = false
        self.stackView.clipsToBounds  = false
        
        self.prepapreConstraints()
    }
    
    private func prepapreConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: offset.top),
            NSLayoutConstraint(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: offset.left),
            NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: stackView, attribute: .bottom, multiplier: 1.0, constant: offset.bottom),
            NSLayoutConstraint(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: offset.right),
            NSLayoutConstraint(item: scrollView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1.0, constant: 0)
            ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: scrollView, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1.0, constant: 0)
        ])
    }
    
    func insert(view: UIView, below: UIView) {
        guard let index = index(view: below) else {
            return
        }
        self.stackView.insertArrangedSubview(view, at: index + 1)
    }
    
    private func index(view : UIView)-> Int? {
        guard let index = stackView.arrangedSubviews.firstIndex(of: view) else {
            return nil
        }
        return index
    }
    
    func add(view: UIView) {
        if let last = stackView.arrangedSubviews.last {
            guard !stackView.arrangedSubviews.contains(view) else { return }
            self.insert(view: view, below: last)
        }else {
            self.stackView.insertArrangedSubview(view, at: 0)
        }
    }
}
