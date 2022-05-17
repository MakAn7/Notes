//
//  createRightBarButton.swift
//  Notes
//
//  Created by Антон Макаров on 16.04.2022.
//

import UIKit
extension ToDoController {
    func createRightBarButton(image name: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: name), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
}
