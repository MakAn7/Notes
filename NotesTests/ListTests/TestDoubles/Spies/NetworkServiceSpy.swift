//  NetworkServiceSpy.swift
//  NotesTests
//  Created by Антон Макаров on 16.06.2022.

import Foundation
@testable import Notes

final class NetworkServiceSpy: Networking {
    private (set) var didFetchModelsWasCalled = false
    private (set) var didFetchImageWasCalled = false
    var fetchResponse: (() -> Void)?

    func fetchModels<T: Decodable>(
        dataType: T.Type,
        from url: String?,
        onSuccess: @escaping ([T]) -> Void,
        onError: @escaping (CurrentError) -> Void
    ) {
        didFetchModelsWasCalled = true
        fetchResponse?()
    }

    func fetchImage(
        with url: URL,
        onSuccess: @escaping (Data, URLResponse) -> Void,
        onError: @escaping (CurrentError) -> Void
    ) {
        didFetchImageWasCalled = true
    }
}
