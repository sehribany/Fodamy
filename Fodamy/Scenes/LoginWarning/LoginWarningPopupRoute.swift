//
//  LoginWarningPopupRoute.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

protocol LoginWarningPopupRoute {
    func presentLoginWarningPopup(loginHandler: @escaping VoidClosure)
}

extension LoginWarningPopupRoute where Self: RouterProtocol {
    
    func presentLoginWarningPopup(loginHandler: @escaping VoidClosure) {
        let router             = LoginWarningPopupRouter()
        let viewModel          = LoginWarningPopupViewModel(router: router)
        let viewController     = LoginWarningPopupViewController(viewModel: viewModel)
        viewModel.loginHandler = loginHandler

        let transition                    = ModalTransition()
        transition.modalPresentationStyle = .overFullScreen
        transition.modalTransitionStyle   = .crossDissolve
        router.viewController             = viewController
        router.openTransition             = transition
        
        open(viewController, transition: transition)
    }
}
