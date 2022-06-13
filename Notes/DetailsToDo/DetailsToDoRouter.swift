//
//  DetailsToDoRouter.swift
//  Notes
//
//  Created by Антон Макаров on 05.06.2022.
//

import UIKit

protocol DetailsToDoRoutingLogic {
    func viewControllerDismiss()
}

class DetailsToDoRouter {
    // слыбая ссылка что бы не было утечки
    weak var viewController: DetailsToDoViewController?
}

extension DetailsToDoRouter: DetailsToDoRoutingLogic {
    func viewControllerDismiss() {
        viewController?.dismiss(animated: true)
    }
}
