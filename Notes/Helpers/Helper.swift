//
//  Helper.swift
//  Notes
//
//  Created by Антон Макаров on 13.04.2022.
//

import UIKit

class Helper {
    static func tamicOff(views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    static func add(subviews: [UIView], superView: UIView) {
        for subview in subviews {
            superView.addSubview(subview)
        }
    }
}
