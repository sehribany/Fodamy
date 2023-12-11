//
//  LoginReequst.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

public struct LoginRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = Auth

    public var path: String = "auth/login"
    public var method: RequestMethod = .post
    public var parameters: RequestParameters = [:]
    public var headers: RequestHeaders = [:]
    
    public init(username: String, password: String) {
        parameters["username"] = username
        parameters["password"] = password
    }
}
