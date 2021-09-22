//
//  ViewController.swift
//  apod
//
//  Created by rafael.rollo on 22/09/21.
//  Turned into LaunchScreenViewController by rafael.rollo on 22/09/21.
//

import UIKit
import Lottie

class LaunchScreenViewController: UIViewController {
    
    private lazy var launchAnimationView: AnimationView = {
        let animation = AnimationView(name: "LaunchAnimation")
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .playOnce
        animation.animationSpeed = 2.5
        return animation
    }()

    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        launchAnimationView.play()
    }
}

extension LaunchScreenViewController: ViewCode {
    func addTheme() {
        view.backgroundColor = .systemBackground
    }
    
    func addViews() {
        view.addSubview(launchAnimationView)
    }
    
    func addConstraints() {
        launchAnimationView.constrainTo(edgesOf: view)
    }
}

