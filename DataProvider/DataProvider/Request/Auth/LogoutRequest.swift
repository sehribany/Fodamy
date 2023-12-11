//
//  LogoutRequest.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

public struct LogoutRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = SuccessResponse
    
    public var path      : String = "auth/logout"
    public var method    : RequestMethod = .post
    public init() {}
}
