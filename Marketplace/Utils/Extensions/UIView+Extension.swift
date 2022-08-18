//
//  UIView+Extension.swift
//  Marketplace
//
//  Created by Marcos Vicente on 14/08/22.
//

import UIKit

extension UIView {

    func enableAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    func setConstraints(to superview: UIView, leading: CGFloat? = nil, top: CGFloat? = nil, trailing: CGFloat? = nil, bottom: CGFloat? = nil, _ priority: UILayoutPriority = .required) {
        setHorizontalConstraints(to: superview, leading: leading, trailing: trailing, priority)
        setVerticalConstraints(to: superview, top: top, bottom: bottom, priority)
    }

    func setCenterConstraint(to superview: UIView) {
        setHorizontalCenterConstraint(to: superview)
        setVerticalCenterConstraint(to: superview)
    }

    func setHorizontalCenterConstraint(to superview: UIView) {
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        ])
    }

    func setVerticalCenterConstraint(to superview: UIView) {
        NSLayoutConstraint.activate([
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])
    }

    func setHorizontalConstraints(to superview: UIView, leading: CGFloat? = nil, trailing: CGFloat? = nil, _ priority: UILayoutPriority = .required) {
        setLeadingConstraint(to: superview, leading: leading, priority)
        setTrailingConstraint(to: superview, trailing: trailing, priority)
    }

    func setLeadingConstraint(to superview: UIView, leading: CGFloat? = nil, _ priority: UILayoutPriority = .required) {
        var constraint = NSLayoutConstraint()

        if let leading = leading {
            constraint = leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading)
        } else {
            constraint = leadingAnchor.constraint(equalTo: superview.leadingAnchor)
        }

        constraint.priority = priority

        NSLayoutConstraint.activate([constraint])
    }

    func setLeadingConstraint(to superview: UIView, trailing: CGFloat? = nil, _ priority: UILayoutPriority = .required) {
        var constraint = NSLayoutConstraint()

        if let trailing = trailing {
            constraint = leadingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailing)
        } else {
            constraint = leadingAnchor.constraint(equalTo: superview.trailingAnchor)
        }

        constraint.priority = priority

        NSLayoutConstraint.activate([constraint])
    }

    func setTrailingConstraint(to superview: UIView, trailing: CGFloat? = nil, _ priority: UILayoutPriority = .required) {
        var constraint = NSLayoutConstraint()

        if let trailing = trailing {
            constraint = trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailing)
        } else {
            constraint = trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        }

        constraint.priority = priority

        NSLayoutConstraint.activate([constraint])
    }

    func setVerticalConstraints(to superview: UIView, top: CGFloat? = nil, bottom: CGFloat? = nil, _ priority: UILayoutPriority = .required) {
        setTopConstraint(to: superview, top: top, priority)
        setBottomConstraint(to: superview, bottom: bottom, priority)
    }

    func setTopConstraint(to superview: UIView, top: CGFloat? = nil, _ priority: UILayoutPriority = .required) {
        var constraint = NSLayoutConstraint()

        if let top = top {
            constraint = topAnchor.constraint(equalTo: superview.topAnchor, constant: top)
        } else {
            constraint = topAnchor.constraint(equalTo: superview.topAnchor)
        }

        constraint.priority = priority

        NSLayoutConstraint.activate([constraint])
    }

    func setBottomConstraint(to superview: UIView, bottom: CGFloat? = nil, _ priority: UILayoutPriority = .required) {
        var constraint = NSLayoutConstraint()

        if let bottom = bottom {
            constraint = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottom)
        } else {
            constraint = bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        }

        constraint.priority = priority

        NSLayoutConstraint.activate([constraint])
    }

    func setWidthConstraint(width: CGFloat) {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width)
        ])
    }

    func setHeightConstraint(height: CGFloat, _ priority: UILayoutPriority = .required) {
        let constraint = heightAnchor.constraint(equalToConstant: height)
        constraint.priority = priority

        NSLayoutConstraint.activate([constraint])
    }

    func setTopConstraint(to superview: UIView, bottom: CGFloat? = nil, _ priority: UILayoutPriority = .required) {
        var constraint = NSLayoutConstraint()

        if let bottom = bottom {
            constraint = topAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottom)
        } else {
            constraint = topAnchor.constraint(equalTo: superview.bottomAnchor)
        }

        constraint.priority = priority

        NSLayoutConstraint.activate([constraint])
    }
}
