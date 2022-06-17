//  Colors.swift
//  Notes
//  Created by Антон Макаров on 21.04.2022.

import UIKit

struct Colors {
    static let shared = Colors()
    private init() {}

    let viewBackround = UIColor(named: "viewBackground")
    let textColor = UIColor(named: "textColor")
}
