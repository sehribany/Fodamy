//
//  NumberOfPerson.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

public struct NumberOfPerson: Codable {
    public let id  : Int?
    public let text: String

    public init(id: Int?, text: String) {
        self.id   = id
        self.text = text
    }
}
