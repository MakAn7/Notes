//
//  TapWithTag.swift
//  Notes
//
//  Created by Антон Макаров on 12.04.2022.
//

import UIKit

    final class TapWithTag: UITapGestureRecognizer {
        var tag: Int

        init(tag: Int, target: Any, action: Selector?) {
            self.tag = tag
            super.init(target: target, action: action)
        }
    }
