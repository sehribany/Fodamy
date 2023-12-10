//
//  LoginWarningPopupViewController.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

import UIKit
import MobilliumBuilders

final class LoginWarningPopupViewController: BaseViewController<LoginWarningPopupViewModel> {
    
    private let contentView = UIViewBuilder()
        .backgroundColor(Asset.Colors.appWhite.color)
        .cornerRadius(4)
        .masksToBounds(true)
        .clipsToBounds(true)
        .build()
    private let imageView = UIImageViewBuilder()
        .image(Asset.Icons.icWarning.image.withRenderingMode(.alwaysTemplate))
        .tintColor(Asset.Colors.appYellow.color)
        .contentMode(.scaleAspectFit)
        .masksToBounds(true)
        .clipsToBounds(true)
        .build()
    private let warningLabel = UILabelBuilder()
        .text(L10n.Components.Action.loginWarning)
        .textAlignment(.center)
        .textColor(Asset.Colors.appCinder.color)
        .font(.font(.nunitoSemiBold, size: .large))
        .build()
    private let stackView = UIStackViewBuilder()
        .axis(.horizontal)
        .alignment(.fill)
        .distribution(.fillEqually)
        .build()
    private let loginButton = UIButtonBuilder()
        .backgroundColor(Asset.Colors.appRed.color)
        .title(L10n.General.login)
        .titleColor(Asset.Colors.appWhite.color)
        .titleFont(.font(.nunitoBold, size: .medium))
        .build()
    private let giveUpButton = UIButtonBuilder()
        .backgroundColor(Asset.Colors.appZircon.color)
        .title(L10n.General.giveUp)
        .titleColor(Asset.Colors.appCinder.color)
        .titleFont(.font(.nunitoBold, size: .medium))
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
    }
}

// MARK: - UILayout
extension LoginWarningPopupViewController {
    
    private func addSubViews() {
        addContentView()
        addImageView()
        addWarningLabel()
        addStackView()
    }
    
    private func addContentView() {
        view.addSubview(contentView)
        contentView.centerYToSuperview()
        contentView.leadingToSuperview().constant  = 25
        contentView.trailingToSuperview().constant = -25
    }
    
    private func addImageView() {
        contentView.addSubview(imageView)
        imageView.centerXToSuperview()
        imageView.topToSuperview().constant = 20
        imageView.size(CGSize(width: 60, height: 60))
    }
    
    private func addWarningLabel() {
        contentView.addSubview(warningLabel)
        warningLabel.topToBottom(of: imageView).constant = 16
        warningLabel.edgesToSuperview(excluding: [.top, .bottom])
    }
    
    private func addStackView() {
        contentView.addSubview(stackView)
        stackView.edgesToSuperview(excluding: .top)
        stackView.topToBottom(of: warningLabel).constant = 15
        stackView.addArrangedSubview(giveUpButton)
        stackView.addArrangedSubview(loginButton)
        loginButton.height(50)
        giveUpButton.height(50)
    }
}

// MARK: - Configure and Set Localize
extension LoginWarningPopupViewController {
    
    private func configureContents() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.40)
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        giveUpButton.addTarget(self, action: #selector(giveUpButtonAction), for: .touchUpInside)
    }
}

// MARK: - Actions
extension LoginWarningPopupViewController {
    
    @objc
    private func loginButtonAction() {
        viewModel.loginButtonAction()
    }
    
    @objc
    private func giveUpButtonAction() {
        viewModel.giveUpButtonAction()
    }
}
