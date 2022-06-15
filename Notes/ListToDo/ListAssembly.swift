//
//  ListAssembly.swift
//  Notes
//
//  Created by Антон Макаров on 05.06.2022.
//

import UIKit

struct ListAssembly {
    static func makeModule() -> UIViewController {
        let controller = ListViewController()
        let interactor = ListInteractor()
        let presenter = ListPresenter()
        let router = ListRouter()
        let listService = ListService()

        controller.interactor = interactor
        controller.router = router
        interactor.presenter = presenter
        interactor.listService = listService
        presenter.viewController = controller
        router.viewController = controller

        return controller
    }
}
