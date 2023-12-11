//
//  LoginRouter.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

final class LoginRouter: Router, LoginRouter.Routes {
    typealias Routes = RegisterRoute & PasswordResetRoute
}
