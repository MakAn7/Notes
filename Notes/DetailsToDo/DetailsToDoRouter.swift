//
//  DetailsToDoRouter.swift
//  Notes
//
//  Created by Антон Макаров on 05.06.2022.
//

import UIKit

protocol DetailsToDoRoutingLogic {
    func viewControllerDismiss(request: DetailModel.DismisDetailController.Request)
}

class DetailsToDoRouter {
    // слыбая ссылка что бы не было утечки
    weak var viewController: DetailsToDoViewController?
}

extension DetailsToDoRouter: DetailsToDoRoutingLogic {
    func viewControllerDismiss(request: DetailModel.DismisDetailController.Request) {
        viewController?.dismiss(animated: true)
    }
}
