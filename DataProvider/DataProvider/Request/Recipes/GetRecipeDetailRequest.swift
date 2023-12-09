//
//  GetRecipeDetailRequest.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 8.12.2023.
//

public struct GetRecipeDetailRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = RecipeDetail
    public var path  : String = "recipe/{recipeId}"
    public var method: RequestMethod = .get
    
    public init(recipeId: Int) {
        self.path = "recipe/\(recipeId)"
    }
}
