//
//  LoginWarningPopupViewModel.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

import Foundation

protocol LoginWarningPopupViewDataSource {}

protocol LoginWarningPopupViewEventSource {}

protocol LoginWarningPopupViewProtocol: LoginWarningPopupViewDataSource, LoginWarningPopupViewEventSource {}

final class LoginWarningPopupViewModel: BaseViewModel<LoginWarningPopupRouter>, LoginWarningPopupViewProtocol {
    
}
