//
//  Comments.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 8.12.2023.
//

public struct Comments: Codable {
    public let data      : [Comment]
    public let pagination: Pagination

    public init(data: [Comment], pagination: Pagination) {
        self.data       = data
        self.pagination = pagination
    }
}
