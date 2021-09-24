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
    
    /// Constrains the top and leading of your view code component to the
    /// same edges of the target view
    ///
    /// - Parameters:
    ///     - view: The target view to constrain to
    ///     - topMargin: The margin to apply as the constant of the top anchor constraint
    ///     - leadingMargin: The margin to apply as the constant of the leading anchor constraint
    ///     - notchSafe: A boolean that flags whether it should use the `safeAreaLayoutGuide`'s
    ///     topAnchor instead of the default one
    ///
    func constrainToTopAndLeading(of view: UIView,
                                  topMargin: CGFloat = 0,
                                  leadingMargin: CGFloat = 0,
                                  notchSafe: Bool = false) {
        let topAnchor = notchSafe ? view.safeTopAnchor : view.topAnchor
        
        let constraints = [
            self.topAnchor.constraint(equalTo: topAnchor, constant: topMargin),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingMargin),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    /// Constrains the top, leading, and trailing of your view code component to
    /// the same edges of the target view
    ///
    /// - Parameters:
    ///     - view: The target view to constrain to
    ///     - topMargin: The margin to apply as the constant of the top anchor constraint
    ///     - horizontalMargin: The margin to apply as the constant of the leading and trailing anchor contraints
    ///     - notchSafe: A boolean that flags whether it should use the `safeAreaLayoutGuide`'s topAnchor
    ///     instead of the default one
    ///
    func constrainToTopAndSides(of view: UIView,
                                topMargin: CGFloat = 0,
                                horizontalMargins horizontalMargin: CGFloat = 0,
                                notchSafe: Bool = false) {
        let topAnchor = notchSafe ? view.safeTopAnchor : view.topAnchor
        
        let constraints = [
            self.topAnchor.constraint(equalTo: topAnchor, constant: topMargin),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
 
    // MARK: - positioning helpers
    
    /// Positions your view code component centering on the target view
    ///
    /// - Parameters:
    ///     - view: The target view to anchor centering
    ///     - point: The point containing the x and y axis offset to apply as the constant of the
    ///     centerX and centerY anchor constraints
    ///
    func anchorToCenter(of view: UIView, withOffset point: CGPoint = .zero) {
        let constraints = [
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: point.x),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: point.y)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - sizing helpers
    
    /// Constrains the size of your view code component
    ///
    /// - Parameters:
    ///     - size: The `CGSize` representing the desired size to the view.
    ///     Define the contants of the widthAnchor and heightAnchor constraints
    ///
    func constrainSize(to size: CGSize) {
        let constraints = [
            self.widthAnchor.constraint(equalToConstant: size.width),
            self.heightAnchor.constraint(equalToConstant: size.height)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    /// Constrains the height of your view code component
    ///
    /// - Parameters:
    ///     - constant: The `CGFloat` representing the desired height to the view.
    ///     Define the constant of the heightAnchor constraint
    ///
    /// - Returns: The activated layout constraint's reference
    ///
    @discardableResult
    func constrainHeight(to constant: CGFloat) -> NSLayoutConstraint {
        let constraint = self.heightAnchor.constraint(equalToConstant: constant)
        constraint.isActive = true
        return constraint
    }
}
