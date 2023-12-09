//
//  BaseResponse.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 8.12.2023.
//

public struct BaseResponse<T: Decodable>: Decodable {
    public let data      : T
    public let pagination: Pagination
}
