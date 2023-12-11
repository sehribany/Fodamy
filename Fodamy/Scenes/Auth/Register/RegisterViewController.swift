//
//  RegisterViewController.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

import UIKit
import MobilliumBuilders

final class RegisterViewController: BaseViewController<RegisterViewModel> {
    
    private let titleLabel = UILabelBuilder()
        .textColor(Asset.Colors.appCinder.color)
        .font(.font(.nunitoBold, size: .xxLarge))
        .build()
    private let verticalStackView = UIStackViewBuilder()
        .axis(.vertical)
        .spacing(15)
        .build()
    private let usernameTextField = FloatLabelTextField()
    private let emailTextField = FloatLabelTextField()
    private let passwordTextField = FloatLabelTextField()
    private let registerButton = ButtonFactory.createPrimaryButton(style: .large)
    private let bottomStackView = UIStackViewBuilder()
        .axis(.horizontal)
        .spacing(4)
        .build()
    private let bottomLabel = UILabelBuilder()
            .font(.font(.nunitoBold, size: .xLarge))
            .textColor(Asset.Colors.appRaven.color)
            .build()
    private let loginScreenButton = UIButtonBuilder()
        .titleColor(Asset.Colors.appRed.color)
            .titleFont(.font(.nunitoBold, size: .xLarge))
            .build()
    private let forgotPasswordButton = UIButtonBuilder()
        .titleFont(.font(.nunitoSemiBold, size: .large))
        .titleColor(Asset.Colors.appRaven.color)
        .build()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        setLocalize()
    }
}
// MARK: - UILayout
extension RegisterViewController {
    
    private func addSubViews() {
        addTitleLabel()
        addStackView()
        addBottomStackView()
    }
    
    private func addTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.topToSuperview(usingSafeArea: true).constant = 50
        titleLabel.centerXToSuperview()
    }
    
    private func addStackView() {
        view.addSubview(verticalStackView)
        verticalStackView.topToBottom(of: titleLabel).constant = 50
        verticalStackView.leadingToSuperview().constant = 15
        verticalStackView.trailingToSuperview().constant = -15
        verticalStackView.addArrangedSubview(usernameTextField)
        verticalStackView.addArrangedSubview(emailTextField)
        verticalStackView.addArrangedSubview(passwordTextField)
        verticalStackView.addArrangedSubview(registerButton)
    }
    
    private func addBottomStackView() {
        view.addSubview(bottomStackView)
        bottomStackView.leadingToSuperview(relation: .equalOrGreater).constant = 20
        bottomStackView.trailingToSuperview(relation: .equalOrLess).constant = -20
        bottomStackView.bottomToSuperview(usingSafeArea: true)
        bottomStackView.centerXToSuperview()
        bottomStackView.addArrangedSubview(bottomLabel)
        bottomStackView.addArrangedSubview(loginScreenButton)
    }
}
// MARK: - Configure and Set Localize
extension RegisterViewController {
    
    private func configureContents() {
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(image: UIImage(), style: .plain, target: self, action: nil)
        usernameTextField.leftImage = Asset.Icons.icUser.image
        emailTextField.leftImage = Asset.Icons.icMail.image
        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        passwordTextField.leftImage = Asset.Icons.icPassword.image
        passwordTextField.isSecureTextEntry = true
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        loginScreenButton.addTarget(self, action: #selector(loginScreenButtonTapped), for: .touchUpInside)
    }
    
    private func setLocalize() {
        titleLabel.text = L10n.General.register
        usernameTextField.title = L10n.Placeholder.username
        emailTextField.title = L10n.Placeholder.email
        passwordTextField.title = L10n.Placeholder.password
        registerButton.setTitle(L10n.Modules.RegisterViewController.title, for: .normal)
        bottomLabel.text = L10n.Modules.RegisterViewController.bottomText
        loginScreenButton.setTitle(L10n.Modules.LoginViewController.title, for: .normal)
    }
}

// MARK: - Actions
extension RegisterViewController {
    
    @objc
    private func loginScreenButtonTapped() {
        viewModel.showLoginScreen()
    }
    
    @objc
    private func registerButtonTapped() {
        view.endEditing(true)
        guard let userName = usernameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text else {
            showWarningToast(message: L10n.Error.emptyFields)
            return
        }
        let validation = Validation()
        guard validation.isValidEmail(email) else { return }
        guard validation.isValidPassword(password) else { return }
        viewModel.sendRegisterRequest(username: userName, email: email, password: password)
    }

}
