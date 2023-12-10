//
//  PostRecipeCommentRequest.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

public struct PostRecipeCommentRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = Comment
    
    public var path      : String = "recipe/{recipeId}/comment"
    public var method    : RequestMethod = .post
    public var parameters: RequestParameters = [:]
    public var headers   : RequestHeaders = [:]
    
    public init(recipeId: Int, text: String) {
        self.path               = "recipe/\(recipeId)/comment"
        self.parameters["text"] = text
    }
}
