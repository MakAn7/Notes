//
//  DetailsToDoAssembly.swift
//  CleanSwiftNotes
//
//  Created by Антон Макаров on 05.06.2022.
//

import UIKit

struct DetailsToDoAssembly {
    static func makeModule() -> UIViewController {
        let controller = DetailsToDoViewController()
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
