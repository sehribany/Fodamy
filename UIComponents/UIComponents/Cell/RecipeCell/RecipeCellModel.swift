//
//  RecipeCellModel.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

import Foundation
import DataProvider

public protocol RecipeCellDataSource: AnyObject {
    var recipe: Recipe { get }
}

public protocol RecipeCellEventSource: AnyObject {}

public protocol RecipeCellProtocol: RecipeCellDataSource, RecipeCellEventSource {}

public final class RecipeCellModel: RecipeCellProtocol {
    public var recipe: Recipe
    
    public init(recipe: Recipe) {
        self.recipe = recipe
    }
}
