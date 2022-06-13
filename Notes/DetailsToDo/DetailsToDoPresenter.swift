//  DetailsToDoPresenter.swift
//  Notes
//
//  Created by Антон Макаров on 05.06.2022.
//

import UIKit

protocol DetailsToDoPresentationLogic {
    func presentModel(model: DetailToDoModel)
}

class DetailsToDoPresenter {
    weak var viewController: DetailsToDoDisplayLogic?
}

extension DetailsToDoPresenter: DetailsToDoPresentationLogic {
    func presentModel(model: DetailToDoModel) {
        viewController?.setValuesFromModel(model: model)
    }
}
