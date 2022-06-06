//
//  DetailsToDoAssembly.swift
//  CleanSwiftNotes
//
//  Created by Антон Макаров on 05.06.2022.
//

import UIKit

struct DetailsToDoAssembly {
    static func makeModuleNewState(delegate: DidUpdateViewAndConstaraintsDelegate) -> UIViewController {
        let controller = DetailsToDoViewController(state: .new, delegate: delegate)
        let interactor = DetailsToDoInteractor()
        let presenter = DetailsToDoPresenter()
        let router = DetailsToDoRouter()

        controller.interactor = interactor
        controller.router = router
        interactor.presenter = presenter
        presenter.viewController = controller
        router.viewController = controller
        return controller
    }

    static func makeModuleEditState(
        cell: ListCellViewModel,
        index: Int,
        delegate: DidUpdateViewAndConstaraintsDelegate
    ) -> UIViewController {
        let controller = DetailsToDoViewController(state: .edit(model: cell, indexRow: index), delegate: delegate)
        let interactor = DetailsToDoInteractor()
        let presenter = DetailsToDoPresenter()
        let router = DetailsToDoRouter()

        controller.interactor = interactor
        controller.router = router
        interactor.presenter = presenter
        presenter.viewController = controller
        router.viewController = controller
        return controller
    }
}
