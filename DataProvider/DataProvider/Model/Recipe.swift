//
//  Recipe.swift
//  DataProvider
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

public struct Recipe: Codable {
    public let id            : Int
    public let title         : String
    public let ingredients   : String
    public let directions    : String
    public let difference    : String
    public let isEditorChoice: Bool
    public let likeCount     : Int
    public let commentCount  : Int
    public let user          : User
    public let timeOfRecipe  : NumberOfPerson
    public let numberOfPerson: NumberOfPerson
    public let category      : Category
    public let images        : [Image]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case ingredients
        case directions
        case difference
        case isEditorChoice = "is_editor_choice"
        case likeCount      = "like_count"
        case commentCount   = "comment_count"
        case user
        case timeOfRecipe   = "time_of_recipe"
        case numberOfPerson = "number_of_person"
        case category
        case images
    }

    public init(id            : Int,
                title         : String,
                ingredients   : String,
                directions    : String,
                difference    : String,
                isEditorChoice: Bool,
                likeCount     : Int,
                commentCount  : Int,
                user          : User,
                timeOfRecipe  : NumberOfPerson,
                numberOfPerson: NumberOfPerson,
                category      : Category,
                images        : [Image]?) {
        self.id             = id
        self.title          = title
        self.ingredients    = ingredients
        self.directions     = directions
        self.difference     = difference
        self.isEditorChoice = isEditorChoice
        self.likeCount      = likeCount
        self.commentCount   = commentCount
        self.user           = user
        self.timeOfRecipe   = timeOfRecipe
        self.numberOfPerson = numberOfPerson
        self.category       = category
        self.images         = images
    }
}
