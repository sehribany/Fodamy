//
//  LoginViewModel.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

import Foundation
import KeychainSwift
import MobilliumUserDefaults

protocol LoginViewDataSource {}

protocol LoginViewEventSource {}

protocol LoginViewProtocol: LoginViewDataSource, LoginViewEventSource {
    func showRegisterScene()
    func dismissLoginScene()
    func pushPasswordResetScene()
    func sendLoginRequest(username: String, password: String)
    func postNotification()
}

final class LoginViewModel: BaseViewModel<LoginRouter>, LoginViewProtocol {
    
    let keychain = KeychainSwift()

    func showRegisterScene() {
        router.pushRegister()
    }
    
    func dismissLoginScene() {
        router.close()
    }
    
    func pushPasswordResetScene() {
        router.pushPasswordReset()
    }
    
    func postNotification() {
        NotificationCenter.default.post(name: .reloadDetailView, object: nil)
    }
}

// MARK: - Network
extension LoginViewModel {
    
    func sendLoginRequest(username: String, password: String) {
        showLoading?()
        dataProvider.request(for: LoginRequest(username: username, password: password)) { [weak self] result in
            guard let self = self else { return }
            self.hideLoading?()
            switch result {
            case .success(let response):
                self.keychain.set(response.token, forKey: Keychain.token)
                DefaultsKey.userId.value = response.user.id
                self.postNotification()
                self.router.close()
            case .failure(let error):
                self.showWarningToast?("\(error.localizedDescription) \(L10n.Error.checkInformations)")
            }
        }
    }
}
