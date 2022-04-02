//
//  AlertError.swift
//  Notes
//
//  Created by Антон Макаров on 01.04.2022.
//

import UIKit

extension MainController {
    func alertShowError(message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
