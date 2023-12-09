//
//  UserFollowRequest.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 8.12.2023.
//

public struct UserFollowRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = SuccessResponse
    public var path      : String = "user/{followedId}/following"
    public var method    : RequestMethod = .post
    public var parameters: RequestParameters = [:]
    public var headers   : RequestHeaders = [:]
    
    public init(followedId: Int, followType: FollowType) {
        self.path = "user/\(followedId)/following"
        switch followType {
        case .follow:
            method = .post
        case .unfollow:
            method = .delete
        }
    }
    
    public enum FollowType {
        case follow
        case unfollow
    }
}
