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
    case decodingError
}

class Worker {
    static let shared = Worker()
    private init() {}

    func fetchToDos<T: Decodable>(
        dataType: T.Type,
        from url: URL?,
        onSuccess: @escaping([T]) -> Void,
        onError: @escaping(CurrentError) -> Void
    ) {
        guard let url = url else {
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
}
