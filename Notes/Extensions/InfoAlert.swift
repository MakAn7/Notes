//
//  InfoAlert.swift
//  Notes
//
//  Created by Антон Макаров on 12.05.2022.
//

import UIKit

extension UIViewController {
    func alertShowError(message: String, title: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
