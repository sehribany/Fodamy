//
//  Comment.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 8.12.2023.
//

public struct Comment: Codable {
    public let id        : Int
    public let text      : String
    public let difference: String
    public let user      : User

    public init(id        : Int,
                text      : String,
                difference: String,
                user: User) {
        self.id         = id
        self.text       = text
        self.difference = difference
        self.user       = user
    }
}
