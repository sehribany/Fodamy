//
//  GetCategoriesWithRecipesRequest.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 8.12.2023.
//

public struct GetCategoriesWithRecipesRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = BaseResponse<[MainCategory]>

    public var path      : String = "category-recipes"
    public var method    : RequestMethod = .get
    public var parameters: RequestParameters = [:]
    
    public init(page: Int) {
        parameters["page"] = page
    }
}
