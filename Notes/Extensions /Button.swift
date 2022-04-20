//
//  Button.swift
//  Notes
//
//  Created by Антон Макаров on 16.04.2022.
//

import UIKit

extension UIButton {
    convenience init(
        title: String,
        bgColor: UIColor,
        textColor: UIColor,
        font: UIFont?
    ) {
        self.init(type: .system)
        setTitle(title, for: .normal)
        backgroundColor = bgColor
        tintColor = textColor
        titleLabel?.font = font!
        layer.cornerRadius = 8
    }
}
