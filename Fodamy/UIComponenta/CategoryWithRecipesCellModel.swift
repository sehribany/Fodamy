//
//  CategoryWithRecipesCellModel.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

import Foundation

extension CategoryWithRecipesCellModel {
    
    convenience init(category: MainCategory) {
        let cellItems = category.recipes.map({ RecipeSmallCellModel(recipe: $0) })
        self.init(categoryId: category.id ?? 0, categoryImageURL: nil, categoryName: category.name, cellItems: cellItems)
    }
}
