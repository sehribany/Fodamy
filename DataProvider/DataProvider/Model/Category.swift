//
//  Category.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

public struct Category: Codable {
    public let id      : Int
    public let name    : String
    public let language: String?
    public let image   : Image?

    public init(id      : Int,
                name    : String,
                language: String?,
                image   : Image?) {
        self.id       = id
        self.name     = name
        self.language = language
        self.image    = image
    }
}
