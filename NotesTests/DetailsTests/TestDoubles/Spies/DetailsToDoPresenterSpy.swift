//  DetailsToDoPresenterSpy.swift
//  NotesTests
//  Created by Антон Макаров on 15.06.2022.

import Foundation
@testable import Notes

final class DetailsToDoPresenterSpy: DetailsToDoPresentationLogic {
    // MARK: - Private Properties
    private (set) var didPresentModelCalled = false

    // MARK: - Public Methods
    func presentModel(model: DetailModel.InitForm.Response) {
        didPresentModelCalled = true
    }
}
