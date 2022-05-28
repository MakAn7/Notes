//
//  Worker.swift
//  Notes
//
//  Created by Антон Макаров on 17.05.2022.
//

import Foundation

enum CurrentError: Error {
    case invalidUrl
    case noData
    case noResponse
    case decodingError
}

class Worker {
    static let shared = Worker()
    private init() {}

    func fetchToDos<T: Decodable>(
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
                let todo = try decoder.decode([T].self, from: data)
                DispatchQueue.main.async {
                    onSuccess(todo)
                }
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
        DispatchQueue.global(qos: .utility).async {
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

                DispatchQueue.main.asyncAfter(
                    deadline: .now() + .seconds(10),
                    execute: {
                        onSuccess(data, response)
                    }
                )
            }.resume()
        }
    }
}
