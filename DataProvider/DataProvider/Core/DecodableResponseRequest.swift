//
//  DecodableResponseRequest.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 1.12.2023.
//

public protocol DecodableResponseRequest : RequestProtocol{
    associatedtype ResponseType : Decodable
}
