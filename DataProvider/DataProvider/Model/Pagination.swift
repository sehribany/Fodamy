//
//  Pagination.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

public struct Pagination: Codable {
    public let total      : Int
    public let perPage    : Int
    public let currentPage: Int
    public let lastPage   : Int
    public let firstItem  : Int
    public let lastItem   : Int

    enum CodingKeys: String, CodingKey {
        case total
        case perPage     = "per_page"
        case currentPage = "current_page"
        case lastPage    = "last_page"
        case firstItem   = "first_item"
        case lastItem    = "last_item"
    }
    
    public init(total      : Int,
                perPage    : Int,
                currentPage: Int,
                lastPage   : Int,
                firstItem  : Int,
                lastItem   : Int) {
        self.total       = total
        self.perPage     = perPage
        self.currentPage = currentPage
        self.lastPage    = lastPage
        self.firstItem   = firstItem
        self.lastItem    = lastItem
    }
}
