//
//  RecipeDetailRoute.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

protocol RecipeDetailRoute {
    func pushRecipeDetail(recipe: Recipe)
}

extension RecipeDetailRoute where Self: RouterProtocol {
    
    func pushRecipeDetail(recipe: Recipe) {
        let router         = RecipeDetailRouter()
        let viewModel      = RecipeDetailViewModel(recipe: recipe, router: router)
        let viewController = RecipeDetailViewController(viewModel: viewModel)
        
        let transition        = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}


