//  DetailsToDoPresenter.swift
//  Notes
//
//  Created by Антон Макаров on 05.06.2022.
//

import UIKit

protocol DetailsToDoPresentationLogic {
    func presentModel(model: DetailModel.InitForm.Response)
}

class DetailsToDoPresenter {
    // слабая ссылка для VIP цикла
    weak var viewController: DetailsToDoDisplayLogic?
}

extension DetailsToDoPresenter: DetailsToDoPresentationLogic {
    func presentModel(model: DetailModel.InitForm.Response) {
        viewController?.displayData(model: DetailModel.InitForm.ViewModel(model: model.model))
    }
}
