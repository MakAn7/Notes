//
//  ListRouter.swift
//  Notes
//
//  Created by Антон Макаров on 03.06.2022.
//

import UIKit

protocol ListRoutingLogic {
    func presentDetailEditModel(
        with model: DetailToDoModel,
        index: Int,
        delegate: SetupConstaraintsDelegate
    )
    func presentDetailNewModel(delegate: SetupConstaraintsDelegate)
}

class ListRouter {
    // слабая ссылка что бы не было утечки 
    weak var viewController: ListViewController?
}

// MARK: Routing Logic
extension ListRouter: ListRoutingLogic {
    func presentDetailNewModel(delegate: SetupConstaraintsDelegate) {
        let detailController = DetailsToDoAssembly.makeModuleNewState(delegate: delegate)
        viewController?.navigationController?.pushViewController(detailController, animated: true)
    }

    func presentDetailEditModel(
        with model: DetailToDoModel,
        index: Int,
        delegate: SetupConstaraintsDelegate
    ) {
        let detailController = DetailsToDoAssembly.makeModuleEditState(
            model: model,
            index: index,
            delegate: delegate
        )
        viewController?.navigationController?.pushViewController(detailController, animated: true)
   }
}
