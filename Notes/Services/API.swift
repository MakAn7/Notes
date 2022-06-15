//  API.swift
//  Notes
//  Created by Антон Макаров on 04.06.2022.

import Foundation

struct API {
    static func getURL() -> String? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "firebasestorage.googleapis.com"
        component.path = "/v0/b/ios-test-ce687.appspot.com/o/lesson8.json"
        component.queryItems = [
            URLQueryItem(name: "alt", value: "media"),
            URLQueryItem(name: "token", value: "215055df-172d-4b98-95a0-b353caca1424")
        ]
        return component.string
    }
}
