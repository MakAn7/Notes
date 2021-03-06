//  NetworkService.swift
//  Notes
//  Created by Антон Макаров on 04.06.2022.

import Foundation

protocol Networking {
    func fetchModels<T: Decodable>(
        dataType: T.Type,
        from url: String?,
        onSuccess: @escaping([T]) -> Void,
        onError: @escaping(CurrentError) -> Void
    )

    func fetchImage(
        with url: URL,
        onSuccess: @escaping(Data, URLResponse) -> Void,
        onError: @escaping(CurrentError) -> Void
    )
}

enum CurrentError: Error {
    case invalidUrl
    case noData
    case noResponse
    case decodingError
}

final class NetworkService: Networking {
    func fetchModels<T: Decodable>(
        dataType: T.Type,
        from url: String?,
        onSuccess: @escaping([T]) -> Void,
        onError: @escaping(CurrentError) -> Void
    ) {
        guard
            let stringUrl = url,
            let url = URL(string: stringUrl) else {
                DispatchQueue.main.async {
                    onError(.invalidUrl)
                }
                return
            }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    onError(.noData)
                }
                print(error?.localizedDescription ?? "No error description")
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                let models = try decoder.decode([T].self, from: data)
                DispatchQueue.main.asyncAfter(
                    deadline: .now() + .seconds(10),
                    execute: {
                        onSuccess(models)
                    }
                )
            } catch {
                DispatchQueue.main.async {
                    onError(.decodingError)
                }
            }
        }.resume()
    }

    func fetchImage(
        with url: URL,
        onSuccess: @escaping(Data, URLResponse) -> Void,
        onError: @escaping(CurrentError) -> Void
    ) {
        DispatchQueue.global(qos: .userInitiated).async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    DispatchQueue.main.async {
                        onError(.noData)
                    }
                    print(error?.localizedDescription ?? "No error description")
                    return
                }
                guard let response = response else {
                    DispatchQueue.main.async {
                        onError(.noResponse)
                    }
                    return
                }

                guard url == response.url else {
                    return
                }

                DispatchQueue.main.async {
                    onSuccess(data, response)
                }
            }.resume()
        }
    }
}
