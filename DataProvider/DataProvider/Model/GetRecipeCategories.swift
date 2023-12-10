//
//  GetRecipeCategories.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

public struct GetRecipeCategories: Codable {
    public let data      : [MainCategory]
    public let pagination: Pagination

    enum CodingKeys: String, CodingKey {
        case data       = "data"
        case pagination = "pagination"
    }

    public init(data: [MainCategory], pagination: Pagination) {
        self.data       = data
        self.pagination = pagination
    }
}
