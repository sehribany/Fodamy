//
//  FavoritesViewModel.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 5.12.2023.
//

import Foundation

protocol FavoritesViewDataSource {}

protocol FavoritesViewEventSource {}

protocol FavoritesViewProtocol: FavoritesViewDataSource, FavoritesViewEventSource {}

final class FavoritesViewModel: BaseViewModel<FavoritesRouter>, FavoritesViewProtocol {
    
}
