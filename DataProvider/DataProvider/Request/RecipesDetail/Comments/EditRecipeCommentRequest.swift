//
//  EditRecipeCommentRequest.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

public struct EditRecipeCommentRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = SuccessResponse
    
    public var path: String = "recipe/{recipeId}/comment/{commentId}"
    public var method: RequestMethod = .put
    public var parameters: RequestParameters = [:]
    public var headers: RequestHeaders = [:]
    
    public init(recipeId: Int, commentId: Int, commentText: String) {
        self.path = "recipe/\(recipeId)/comment/\(commentId)"
        self.parameters["text"] = commentText
    }
}
