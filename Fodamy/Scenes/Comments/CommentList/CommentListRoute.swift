//
//  CommentListRoute.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

protocol CommentListRoute {
    func pushCommentList(recipeId: Int, isKeyboardOpen: Bool?)
}

extension CommentListRoute where Self: RouterProtocol {
    
    func pushCommentList(recipeId: Int, isKeyboardOpen: Bool?) {
        let router                    = CommentListRouter()
        let viewModel                 = CommentListViewModel(recipeId: recipeId, router: router)
        let viewController            = CommentListViewController(viewModel: viewModel)
        viewController.isKeyboardOpen = isKeyboardOpen ?? false
        let transition                = PushTransition()
        router.viewController         = viewController
        router.openTransition         = transition
        
        open(viewController, transition: transition)
    }
}
