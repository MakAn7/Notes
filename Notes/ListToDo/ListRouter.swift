//
//  ListRouter.swift
//  Notes
//
//  Created by Антон Макаров on 03.06.2022.
//

import UIKit

protocol ListRoutingLogic {
    func presentDetailEditModel(
        with cell: ListCellViewModel,
        index: Int,
        delegate: setupConstaraintsDelegate
    )
    func presentDetailNewModel(delegate: setupConstaraintsDelegate)
}

class ListRouter {
  weak var viewController: ListViewController?
}

// MARK: Routing Logic
extension ListRouter: ListRoutingLogic {
    func presentDetailNewModel(delegate: setupConstaraintsDelegate) {
        let detailController = DetailsToDoAssembly.makeModuleNewState(delegate: delegate)
        viewController?.navigationController?.pushViewController(detailController, animated: true)
    }

    func presentDetailEditModel(
        with cell: ListCellViewModel,
        index: Int,
        delegate: setupConstaraintsDelegate
    ) {
        let detailController = DetailsToDoAssembly.makeModuleEditState(
            cell: cell,
            index: index,
            delegate: delegate
        )
        viewController?.navigationController?.pushViewController(detailController, animated: true)
   }
}
