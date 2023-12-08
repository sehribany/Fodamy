//
//  HomeViewModel.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 5.12.2023.
//

import Foundation

protocol HomeViewDataSource {
    var segmentedControlTitles: [String] { get }
    var selectedSegmentIndex  : Int { get }
}

protocol HomeViewEventSource {}

protocol HomeViewProtocol: HomeViewDataSource, HomeViewEventSource {}

final class HomeViewModel: BaseViewModel<HomeRouter>, HomeViewProtocol {

    var selectedSegmentIndex  : Int = 0
    var segmentedControlTitles: [String] = [L10n.Modules.Home.editorChoiceRecipes,
                                            L10n.Modules.Home.lastAddedRecipes]
}

