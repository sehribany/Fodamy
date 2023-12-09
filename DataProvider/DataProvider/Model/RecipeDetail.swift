//
//  RecipeDetail.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 8.12.2023.
//

public struct RecipeDetail: Codable {
    public let id                   : Int
    public let title                : String
    public let definition           : String
    public let language             : String
    public let ingredients          : String
    public let directions           : String
    public var isLiked              : Bool
    public var isFavorited          : Bool
    public let difference           : String
    public let isEditorChoice       : Bool
    public let isOwner              : Bool
    public let likeCount            : Int
    public let numberOfFavoriteCount: Int
    public let commentCount         : Int
    public let isApproved           : Bool
    public let user                 : User
    public let timeOfRecipe         : NumberOfPerson
    public let numberOfPerson       : NumberOfPerson
    public let category             : Category
    public let images               : [Image]

    enum CodingKeys: String, CodingKey {
        case id                    = "id"
        case title                 = "title"
        case definition            = "definition"
        case language              = "language"
        case ingredients           = "ingredients"
        case directions            = "directions"
        case isLiked               = "is_liked"
        case isFavorited           = "is_favorited"
        case difference            = "difference"
        case isEditorChoice        = "is_editor_choice"
        case isOwner               = "is_owner"
        case likeCount             = "like_count"
        case numberOfFavoriteCount = "number_of_favorite_count"
        case commentCount          = "comment_count"
        case isApproved            = "is_approved"
        case user                  = "user"
        case timeOfRecipe          = "time_of_recipe"
        case numberOfPerson        = "number_of_person"
        case category              = "category"
        case images                = "images"
    }

    public init(id                   : Int,
                title                : String,
                definition           : String,
                language             : String,
                ingredients          : String,
                directions           : String,
                isLiked              : Bool,
                isFavorited          : Bool,
                difference           : String,
                isEditorChoice       : Bool,
                isOwner              : Bool,
                likeCount            : Int,
                numberOfFavoriteCount: Int,
                commentCount         : Int,
                isApproved           : Bool,
                user                 : User,
                timeOfRecipe         : NumberOfPerson,
                numberOfPerson       : NumberOfPerson,
                category             : Category,
                images               : [Image]) {
        self.id                    = id
        self.title                 = title
        self.definition            = definition
        self.language              = language
        self.ingredients           = ingredients
        self.directions            = directions
        self.isLiked               = isLiked
        self.isFavorited           = isFavorited
        self.difference            = difference
        self.isEditorChoice        = isEditorChoice
        self.isOwner               = isOwner
        self.likeCount             = likeCount
        self.numberOfFavoriteCount = numberOfFavoriteCount
        self.commentCount          = commentCount
        self.isApproved            = isApproved
        self.user                  = user
        self.timeOfRecipe          = timeOfRecipe
        self.numberOfPerson        = numberOfPerson
        self.category              = category
        self.images                = images
    }
}
