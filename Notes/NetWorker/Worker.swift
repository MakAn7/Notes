//
//  Worker.swift
//  Notes
//
//  Created by Антон Макаров on 17.05.2022.
//

import Foundation

enum CurrentError: Error {
    case invalidUrl
    case noDate
    case decodingError
}

class Worker {
    static let shared = Worker()
    private init() {}

    func fetchToDos(from url: String, completion: @escaping(Result<[ToDo], CurrentError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }

        URLSession.shared.dataTask(with: url) { date, _, error in
            if let error = error {
                print(error.localizedDescription)
            }

            guard let date = date else {
                completion(.failure(.noDate))
                print(error?.localizedDescription ?? "NoDate")
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                let todo = try decoder.decode([ToDo].self, from: date)
                DispatchQueue.main.async {
                    completion(.success(todo))
                }
            } catch {
                completion(.failure(.decodingError))
                print(error.localizedDescription)
            }
        }.resume()
    }
}
