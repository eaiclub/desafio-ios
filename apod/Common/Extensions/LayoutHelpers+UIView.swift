//
//  LayoutHelpers+UIView.swift
//  apod
//
//  Created by rafael.rollo on 22/09/21.
//

import UIKit

extension UIView {
    
    // MARK: - safe anchors
    var safeTopAnchor: NSLayoutYAxisAnchor {
        return safeAreaLayoutGuide.topAnchor
    }
    
    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        return safeAreaLayoutGuide.leadingAnchor
    }
    
    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        return safeAreaLayoutGuide.trailingAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        return safeAreaLayoutGuide.bottomAnchor
    }
    
    // MARK: - containing helpers
    
    /// Constrains the bounds of your view code component to the bounds of its superview.
    ///
    /// - Parameters:
    ///     - view: The target view to constrain to
    ///     - verticalMargin: The margin to apply as the constant of the top and bottom anchor constraints
    ///     - horizontalMargin: The margin to apply as the constant of the leading and trailing anchor constraints
    ///
    func constrainTo(edgesOf view: UIView,
                     verticalMargins verticalMargin: CGFloat = .zero,
                     horizontalMargins horizontalMargin: CGFloat = .zero) {
        let constraints = [
            topAnchor.constraint(equalTo: view.topAnchor, constant: verticalMargin),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -verticalMargin),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    /// Constrains the bounds of your view code component to the bounds of the
    /// safeAreaLayoutGuide of its superview
    ///
    /// - Parameters:
    ///     - view: The target view to constrain to `safeAreaLayoutGuide`
    ///     - verticalMargin: The margin to apply as the constant of the top and bottom anchor constraints
    ///     - horizontalMargin: The margin to apply as the constant of the leading and trailing anchors constraints
    ///
    func constrainTo(safeEdgesOf view: UIView,
                     verticalMargins verticalMargin: CGFloat = 0,
                     horizontalMargins horizontalMargin: CGFloat = 0) {
        let constraints = [
            topAnchor.constraint(equalTo: view.safeTopAnchor, constant: verticalMargin),
            leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: horizontalMargin),
            bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -verticalMargin),
            trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -horizontalMargin),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
