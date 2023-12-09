//
//  RecipeSmallCellModel.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

import Foundation
import DataProvider

public protocol RecipeSmallCellDataSource: AnyObject {
    var recipe: Recipe { get }
}

public protocol RecipeSmallCellEventSource: AnyObject {}

public protocol RecipeSmallCellProtocol: RecipeSmallCellDataSource, RecipeSmallCellEventSource {}

public final class RecipeSmallCellModel: RecipeSmallCellProtocol {
    public var recipe: Recipe
    
    public init(recipe: Recipe) {
        self.recipe = recipe
    }
}
