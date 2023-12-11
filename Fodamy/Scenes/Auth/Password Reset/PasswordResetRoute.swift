//
//  PasswordResetRoute.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

protocol PasswordResetRoute {
    func pushPasswordReset()
}

extension PasswordResetRoute where Self: RouterProtocol {
    
    func pushPasswordReset() {
        let router         = PasswordResetRouter()
        let viewModel      = PasswordResetViewModel(router: router)
        let viewController = PasswordResetViewController(viewModel: viewModel)
        
        let transition        = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
