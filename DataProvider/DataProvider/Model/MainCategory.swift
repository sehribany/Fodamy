//
//  MainCategory.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 8.12.2023.
//

public struct MainCategory: Codable {
    public let id     : Int
    public let name   : String?
    public let recipes: [Recipe]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case recipes
    }
}
