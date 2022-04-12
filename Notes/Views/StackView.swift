//
//  StackView.swift
//  Notes
//
//  Created by Антон Макаров on 08.04.2022.
//

import UIKit

extension UIStackView {
    convenience init(
        views: [UIView],
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat
    ) {
        self.init(arrangedSubviews: views)
        self.axis = axis
        self.spacing = spacing
    }
}
