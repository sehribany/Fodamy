//
//  FoodCardViewModel.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//
import DataProvider

public protocol FoodCardViewDataSource: AnyObject{
    var recipe: Recipe { get }
}

public protocol FoodCardViewEventSource: AnyObject {}

public protocol FoodCardViewProtocol: FoodCardViewDataSource, FoodCardViewEventSource {}

public final class FoodCardViewModel: FoodCardViewProtocol{
    public var recipe: Recipe
    
    public init(recipe: Recipe) {
        self.recipe = recipe
    }
}
