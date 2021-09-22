//
//  ViewController.swift
//  apod
//
//  Created by rafael.rollo on 22/09/21.
//

import UIKit

class ViewController: UIViewController {

    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: ViewCode {
    func addTheme() {
        view.backgroundColor = .systemBackground
    }
}

