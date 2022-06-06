//
//  ListRouter.swift
//  Notes
//
//  Created by Антон Макаров on 03.06.2022.
//

import UIKit

protocol ListRoutingLogic {
    func presentDetail(cell: ListCellViewModel, index: Int)
}

class ListRouter {
  weak var viewController: ListViewController?
}

// MARK: Routing Logic
extension ListRouter: ListRoutingLogic {
    func presentDetail(cell: ListCellViewModel, index: Int) {
        let controller = DetailsToDoAssembly.makeModule()
        guard let detailVC = controller as? DetailsToDoViewController else { return }
        detailVC.model = cell
        detailVC.indexRow = index
        detailVC.stateNew = false

        viewController?.navigationController?.pushViewController(detailVC, animated: true)
   }
}
