//  DetailsToDoViewControllerSpy.swift
//  NotesTests
//  Created by Антон Макаров on 16.06.2022.

import Foundation
@testable import Notes

final class DetailsToDoViewControllerSpy: DetailsToDoDisplayLogic {
    // MARK: - Private Properties
    private (set) var didDisplayDataCalled = false

    // MARK: - Public Methods
    func displayData(model: DetailModel.InitForm.ViewModel) {
        didDisplayDataCalled = true
    }
}
