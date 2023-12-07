//
//  Recipes.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

public struct Recipes: Codable {
    public let data      : [Recipe]
    public let pagination: Pagination

    public init(data: [Recipe], pagination: Pagination) {
        self.data       = data
        self.pagination = pagination
    }
}
