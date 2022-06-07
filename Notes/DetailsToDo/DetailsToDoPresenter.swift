//  DetailsToDoPresenter.swift
//  Notes
//
//  Created by Антон Макаров on 05.06.2022.
//

import UIKit

protocol DetailsToDoPresentationLogic {
}

class DetailsToDoPresenter {
    weak var viewController: DetailsToDoDisplayLogic?
}

extension DetailsToDoPresenter: DetailsToDoPresentationLogic {
}
