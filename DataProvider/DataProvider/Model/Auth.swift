//
//  Auth.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

public struct Auth: Decodable {
    public let token: String
    public let user : User
}
