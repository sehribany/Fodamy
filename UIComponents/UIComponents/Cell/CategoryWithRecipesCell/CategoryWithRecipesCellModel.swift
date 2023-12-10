//
//  CategoryWithRecipesCellModel.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

import Utilities
import DataProvider

public protocol CategoryWithRecipesCellDataSource: AnyObject {
    var categoryId      : Int { get }
    var categoryImageURL: String? { get }
    var categoryName    : String? { get }
    var cellItems       : [RecipeSmallCellProtocol] { get }
}

public protocol CategoryWithRecipesCellEventSource: AnyObject {
    var didSelectRecipe   : RecipeClosure? { get set }
    var seeAllButtonTapped: ((Int, String) -> Void)? { get set }
}

public protocol CategoryWithRecipesCellProtocol: CategoryWithRecipesCellDataSource, CategoryWithRecipesCellEventSource {}

public final class CategoryWithRecipesCellModel: CategoryWithRecipesCellProtocol {
    public var categoryId        : Int
    public var categoryImageURL  : String?
    public var categoryName      : String?
    public var seeAllButtonTapped: ((Int, String) -> Void)?
    public var cellItems         : [RecipeSmallCellProtocol]
    public var didSelectRecipe   : RecipeClosure?
    
    public init(categoryId: Int, categoryImageURL: String?, categoryName: String?, cellItems: [RecipeSmallCellProtocol]) {
        self.categoryId       = categoryId
        self.categoryImageURL = categoryImageURL
        self.categoryName     = categoryName
        self.cellItems        = cellItems
    }
}
