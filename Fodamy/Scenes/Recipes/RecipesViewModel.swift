//
//  RecipesViewModel.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

import UIComponents

protocol RecipesViewDataSource {
    func numberOfItemsAt(section: Int) -> Int
    func cellItemAt(indexPath: IndexPath) -> RecipeCellProtocol
}

protocol RecipesViewEventSource {
    var didSuccessFetchRecipes: VoidClosure? { get set }
}

protocol RecipesViewProtocol: RecipesViewDataSource, RecipesViewEventSource {
    func showRecipeDetailScreen(at indexPath: IndexPath)
}

final class RecipesViewModel: BaseViewModel<RecipesRouter>, RecipesViewProtocol {
    
    var didSuccessFetchRecipes: VoidClosure?
    var cellItems: [RecipeCellProtocol] = []
    var page             = 1
    var isPagingEnabled  = false
    var isRequestEnabled = false
    var recipesListingType: ListingType
    var title: String?

    func showRecipeDetailScreen(at indexPath: IndexPath) {
        let recipes = cellItems[indexPath.row]
        router.pushRecipeDetail(recipe: recipes.recipe)
    }
    func numberOfItemsAt(section: Int) -> Int {
        return cellItems.count
    }
    
    func cellItemAt(indexPath: IndexPath) -> RecipeCellProtocol {
        return cellItems[indexPath.row]
    }
 
    init(recipesListingType: ListingType, router: RecipesRouter) {
        self.recipesListingType = recipesListingType
        super.init(router: router)
    }
}

// MARK: - Network
extension RecipesViewModel {
    
    func fetchRecipesListingType() {
        var request: GetRecipeRequest
        switch recipesListingType {
        case .editorChoiceRecipes:
            request = GetRecipeRequest(page: page, listingType: .editorChoiceRecipes)
        case .recentlyAddedRecipes:
            request = GetRecipeRequest(page: page, listingType: .recentlyAddedRecipes)
        case .categoryRecipes(let categoryId):
            request = GetRecipeRequest(page: page, listingType: .categoryRecipes(categoryId: categoryId))
        }
        self.isRequestEnabled = false
        
        if page == 1 { showActivityIndicatorView?() }
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            self.isRequestEnabled = true
            switch result {
            case .success(let response):
                let cellItems = response.data.map({ RecipeCellModel(recipe: $0) })
                self.cellItems.append(contentsOf: cellItems)
                self.page += 1
                self.isPagingEnabled = response.pagination.currentPage < response.pagination.lastPage
                self.didSuccessFetchRecipes?()
            case .failure(let error):
                if self.page == 1 { self.showWarningToast?("\(error.localizedDescription)") }
            }
        }
    }
  
    func fetchMorePages() {
        fetchRecipesListingType()
    }
}
