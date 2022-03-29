//
//  TextField + Extension.swift
//  Notes
//
//  Created by Антон Макаров on 26.03.2022.
//

import UIKit

extension UITextField {
    
    convenience init(placeholder: String, isShadow: Bool = true) {
        
        self.init(frame: CGRect())
        self.placeholder = placeholder

        if isShadow {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowRadius = 5
            layer.shadowOpacity = 0.5
            layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        }
    }
}
