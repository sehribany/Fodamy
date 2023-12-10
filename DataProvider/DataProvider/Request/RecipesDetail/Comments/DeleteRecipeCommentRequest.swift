//
//  DeleteRecipeCommentRequest.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

public struct DeleteRecipeCommentRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = SuccessResponse
    
    public var path: String = "recipe/{recipeId}/comment/{commentId}"
    public var method: RequestMethod = .delete
    public var parameters: RequestParameters = [:]
    public var headers: RequestHeaders = [:]
    
    public init(recipeId: Int,
                commentId: Int) {
        self.path = "recipe/\(recipeId)/comment/\(commentId)"
    }
}
