//
//  LoginWarningPopupViewModel.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

protocol LoginWarningPopupViewDataSource {}

protocol LoginWarningPopupViewEventSource {
    var loginHandler: VoidClosure? { get set }
}

protocol LoginWarningPopupViewProtocol: LoginWarningPopupViewDataSource, LoginWarningPopupViewEventSource {
    func giveUpButtonAction()
    func loginButtonAction()
}

final class LoginWarningPopupViewModel: BaseViewModel<LoginWarningPopupRouter>, LoginWarningPopupViewProtocol {
    func giveUpButtonAction() {
        router.close()
    }
    
    func loginButtonAction() {
        router.close()
        loginHandler?()
    }
    
    var loginHandler: VoidClosure?
}
