//
//  FavoriteCardViewModel.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

import DataProvider

public protocol FavoriteCardViewDataSource: AnyObject {
    var recipe: Recipe { get }
}

public protocol FavoriteCardViewEventSource: AnyObject {}

public protocol FavoriteCardViewProtocol: FavoriteCardViewDataSource, FavoriteCardViewEventSource {}

public final class FavoriteCardViewModel: FavoriteCardViewProtocol {
    public var recipe: Recipe
    
    public init(recipe: Recipe) {
        self.recipe = recipe
    }
}
