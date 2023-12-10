//
//  FavoritesViewModel.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 5.12.2023.
//

import Foundation
import UIComponents

protocol FavoritesViewDataSource {
    var numberOfItems: Int { get }
    func cellItem(for indexPath: IndexPath) -> CategoryWithRecipesCellProtocol
}

protocol FavoritesViewEventSource {
    var didSuccessFetchCategories: VoidClosure? { get set }
    var didSuccesLogout          : VoidClosure? { get set }
}

protocol FavoritesViewProtocol: FavoritesViewDataSource, FavoritesViewEventSource {
    func fetchCategories()
    func fetchMorePages()
    func seeAllButtonTapped(categoryId: Int, title: String)
    func didSelectRecipe(recipe: Recipe)
    func userLogout()
}

final class FavoritesViewModel: BaseViewModel<FavoritesRouter>, FavoritesViewProtocol {
    
    private var page = 1
    var isRequestEnabled = false
    var isPagingEnabled = false
    var cellItems: [CategoryWithRecipesCellModel] = []
    var didSuccessFetchCategories: VoidClosure?
    var didSuccesLogout: VoidClosure?
    
    var numberOfItems: Int {
        return cellItems.count
    }
    
    func cellItem(for indexPath: IndexPath) -> CategoryWithRecipesCellProtocol {
        let cellItem = cellItems[indexPath.item]
        return cellItem
    }
}

// MARK: Actions
extension FavoritesViewModel {
    
    func seeAllButtonTapped(categoryId: Int, title: String) {
        router.pushRecipes(categoryId: categoryId, title: title)
    }
    
    func didSelectRecipe(recipe: Recipe) {
        router.pushRecipeDetail(recipe: recipe)
    }
    
    func fetchMorePages() {
        fetchCategories()
    }
}

// MARK: - Network
extension FavoritesViewModel {
    
    func fetchCategories() {
        self.isRequestEnabled = false
        if page == 1 { showActivityIndicatorView?() }
        let request = GetCategoriesWithRecipesRequest(page: page)
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            self.isRequestEnabled = true
            switch result {
            case .success(let response):
                let cellItems = response.data.map({ CategoryWithRecipesCellModel(category: $0) })
                self.cellItems.append(contentsOf: cellItems)
                self.page += 1
                self.isPagingEnabled = response.pagination.currentPage < response.pagination.lastPage
                self.didSuccessFetchCategories?()
            case .failure(let error):
                print(error)
                if self.page == 1 { self.showWarningToast?(L10n.Error.refreshFromTop) }
            }
        }
    }
    
    func userLogout() {
        showLoading?()
        let request = LogoutRequest()
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideLoading?()
            switch result {
            case .success(_ ):
                self.didSuccesLogout?()
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
}
