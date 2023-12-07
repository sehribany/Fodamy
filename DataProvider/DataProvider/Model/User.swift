//
//  User.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

public struct User: Codable {
    public let id             : Int
    public let username       : String
    public let isTopUserChoice: Bool
    public let followedCount  : Int
    public let followingCount : Int
    public let recipeCount    : Int
    public let isFollowing    : Bool
    public let favoritesCount : Int
    public let likesCount     : Int
    public let image          : Image?

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case isTopUserChoice = "is_top_user_choice"
        case followedCount   = "followed_count"
        case followingCount  = "following_count"
        case recipeCount     = "recipe_count"
        case isFollowing     = "is_following"
        case favoritesCount  = "favorites_count"
        case likesCount      = "likes_count"
        case image
    }

    public init(id             : Int,
                username       : String,
                isTopUserChoice: Bool,
                followedCount  : Int,
                followingCount : Int,
                recipeCount    : Int,
                isFollowing    : Bool,
                favoritesCount : Int,
                likesCount     : Int,
                image          : Image?) {
        self.id              = id
        self.username        = username
        self.isTopUserChoice = isTopUserChoice
        self.followedCount   = followedCount
        self.followingCount  = followingCount
        self.recipeCount     = recipeCount
        self.isFollowing     = isFollowing
        self.favoritesCount  = favoritesCount
        self.likesCount      = likesCount
        self.image           = image
    }
}

