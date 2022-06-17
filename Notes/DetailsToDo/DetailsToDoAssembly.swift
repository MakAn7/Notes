//  DetailsToDoAssembly.swift
//  Notes
//  Created by Антон Макаров on 05.06.2022.

import UIKit

struct DetailsToDoAssembly {
    static func makeModuleNewState(delegate: SetupConstaraintsDelegate) -> UIViewController {
        let controller = DetailsToDoViewController()
        let interactor = DetailsToDoInteractor(state: .new)
        let presenter = DetailsToDoPresenter()
        let router = DetailsToDoRouter()
        let userDefaultService = UserDefaultsService()

        controller.delegate = delegate
        controller.interactor = interactor
        controller.router = router
        interactor.presenter = presenter
        interactor.userDefaultsService = userDefaultService
        presenter.viewController = controller
        router.viewController = controller
        return controller
    }

    static func makeModuleEditState(
        model: DetailToDoModel,
        index: Int,
        delegate: SetupConstaraintsDelegate
    ) -> UIViewController {
        let controller = DetailsToDoViewController()
        let interactor = DetailsToDoInteractor(state: .edit(model: model, indexRow: index))
        let presenter = DetailsToDoPresenter()
        let router = DetailsToDoRouter()
        let userDefaultService = UserDefaultsService()

        controller.delegate = delegate
        controller.interactor = interactor
        controller.router = router
        interactor.presenter = presenter
        interactor.userDefaultsService = userDefaultService
        presenter.viewController = controller
        router.viewController = controller
        return controller
    }
}
