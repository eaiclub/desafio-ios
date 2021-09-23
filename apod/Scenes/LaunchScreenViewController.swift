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
        animation.animationSpeed = 3
        return animation
    }()
    
    private lazy var logo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .galada(size: 48)
        label.textColor = .label
        label.text = "Apod"
        
        label.layer.shadowOffset = .zero
        label.layer.shadowOpacity = 1
        label.layer.shadowRadius = 2
        label.layer.shadowColor = UIColor.systemBackground.cgColor
        
        label.alpha = 0
        return label
    }()

    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        launchAnimationView.play(fromFrame: 5,
                                 toFrame: 115,
                                 loopMode: .playOnce) { [weak self] _ in
            self?.animateLogo()
        }
    }
    
    private func animateLogo() {
        UIView.transition(with: logo,
                          duration: 0.3,
                          options: .transitionFlipFromLeft) { [weak self] in
            self?.logo.alpha = 1
        } completion: { _ in
            print("Launch animation completes")
        }
    }
}

extension LaunchScreenViewController: ViewCode {
    func addTheme() {
        view.backgroundColor = .systemBackground
    }
    
    func addViews() {
        view.addSubview(launchAnimationView)
        view.addSubview(logo)
    }
    
    func addConstraints() {
        launchAnimationView.constrainTo(edgesOf: view)
        logo.anchorToCenter(of: launchAnimationView,
                            withOffset: .init(x: 78, y: 42))
    }
}

