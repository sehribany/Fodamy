//
//  HomeViewModel.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 5.12.2023.
//

import Foundation
import DataProvider

protocol HomeViewDataSource {
    var segmentedControlTitles: [String] { get }
    var selectedSegmentIndex  : Int { get }
}

protocol HomeViewEventSource {
    var didSuccesLogout: VoidClosure? { get set }
}

protocol HomeViewProtocol: HomeViewDataSource, HomeViewEventSource {
    func pushDetailViewController(recipe: Recipe)
    func userLogout()
}

final class HomeViewModel: BaseViewModel<HomeRouter>, HomeViewProtocol {

    var didSuccesLogout       : VoidClosure?
    var selectedSegmentIndex  : Int = 0
    var segmentedControlTitles: [String] = [L10n.Modules.Home.editorChoiceRecipes,
                                            L10n.Modules.Home.lastAddedRecipes]
}

// MARK: - Actions
extension HomeViewModel {
    
    func pushDetailViewController(recipe: Recipe) {
        router.pushRecipeDetail(recipe: recipe)
    }
}

// MARK: - Network
extension HomeViewModel {
    
    func userLogout() {
        showLoading?()
        let request = LogoutRequest()
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideLoading?()
            switch result {
            case .success(let response):
                self.didSuccesLogout?()
                print(response.message)
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
}
