//
//  PasswordResetViewController.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

import UIKit
import MobilliumBuilders

final class PasswordResetViewController: BaseViewController<PasswordResetViewModel> {
    
    private let titleLabel = UILabelBuilder()
        .textColor(Asset.Colors.appCinder.color)
        .font(.font(.nunitoBold, size: .xxLarge))
        .build()
    private let stackView = UIStackViewBuilder()
        .axis(.vertical)
        .spacing(15)
        .build()
    private var emailTextField = FloatLabelTextField()
    private var resetButton    = ButtonFactory.createPrimaryButton(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        setLocalize()
    }
}

// MARK: - UILayout
extension PasswordResetViewController {
    
    private func addSubViews() {
        addTitleLabel()
        addStackView()
    }
    private func addTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.topToSuperview(usingSafeArea: true).constant = 50
        titleLabel.centerXToSuperview()
    }
    
    private func addStackView() {
        view.addSubview(stackView)
        stackView.topToBottom(of: titleLabel).constant = 50
        stackView.leadingToSuperview().constant = 15
        stackView.trailingToSuperview().constant = -15
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(resetButton)
    }
}

// MARK: - Configure and Set Localize
extension PasswordResetViewController {
    
    private func configureContents() {
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(image: UIImage(), style: .plain, target: self, action: nil)
        emailTextField.leftImage = Asset.Icons.icMail.image
        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    private func setLocalize() {
        titleLabel.text = L10n.Modules.PasswordResetController.title
        emailTextField.title = L10n.Placeholder.email
        resetButton.setTitle(L10n.Modules.PasswordResetController.reset, for: .normal)
    }
}

// MARK: - Actions
extension PasswordResetViewController {
    
    @objc
    private func resetButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty else {
            showWarningToast(message: L10n.Error.empty(L10n.Error.Key.email))
            return
        }
        let validation = Validation()
        guard validation.isValidEmail(email) else { return }
        
        viewModel.passwordReset(email: email)
    }
}
