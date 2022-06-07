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
        let detailVC = DetailsToDoAssembly.makeModuleNewState(delegate: delegate)
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }

    func presentDetailEditModel(
        with cell: ListCellViewModel,
        index: Int,
        delegate: setupConstaraintsDelegate
    ) {
        let detailVC = DetailsToDoAssembly.makeModuleEditState(
            cell: cell,
            index: index,
            delegate: delegate
        )
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
   }
}
