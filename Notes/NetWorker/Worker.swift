//
//  Worker.swift
//  Notes
//
//  Created by Антон Макаров on 17.05.2022.
//

import Foundation

// enum CurrentError: Error {
//    case invalidUrl
//    case noData
//    case noResponse
//    case decodingError
// }
// В данном классе в closure  нет необходимости ставить слабые ссылки или безхозные,
// поскольку нет в области захвата свойств класса.
// class Worker {
//    static let shared = Worker()
//    private init() {}
//
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

                DispatchQueue.main.async {
                   onSuccess(data, response)
                }
            }.resume()
        }
    }
// }
