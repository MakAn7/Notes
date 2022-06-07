//  DetailsToDoPresenter.swift
//  Notes
//
//  Created by Антон Макаров on 05.06.2022.
//

import UIKit

protocol DetailsToDoPresentationLogic {
    func didPresentModels(models: [ListCellViewModel])
}

class DetailsToDoPresenter {
    weak var viewController: DetailsToDoDisplayLogic?
}

extension DetailsToDoPresenter: DetailsToDoPresentationLogic {
    func didPresentModels(models: [ListCellViewModel]) {
    }
}
