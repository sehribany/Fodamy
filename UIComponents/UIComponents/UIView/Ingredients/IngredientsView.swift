//
//  IngredientsView.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

import UIKit
import MobilliumBuilders

public class IngredientsView: UIView {
    
    private let titleLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .xLarge))
        .textColor(.appCinder)
        .textAlignment(.left)
        .text(L10n.General.recipeIngredients)
        .build()
    private let stackView = UIStackViewBuilder()
        .spacing(2)
        .axis(.vertical)
        .alignment(.center)
        .build()
    private let iconImageView = UIImageViewBuilder()
        .contentMode(.center)
        .clipsToBounds(true)
        .tintColor(.appCinder)
        .size(CGSize(width: 34, height: 34))
        .cornerRadius(17)
        .clipsToBounds(true)
        .borderWidth(2)
        .borderColor(UIColor.appZircon.cgColor)
        .image(.icRestaurant)
        .build()
    private let numberOfPersonLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .small))
        .textColor(.appRaven)
        .build()
    private let lineView = UIViewBuilder()
        .backgroundColor(.appZircon)
        .build()
    private let ingredientsLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .xLarge))
        .textColor(.appCinder)
        .numberOfLines(0)
        .build()
    weak var viewModel: IngredientsViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureContents()
        addSubViews()
    }
}

// MARK: - UILayout
extension IngredientsView {
    
    private func addSubViews() {
        addTitleLabel()
        addStackView()
        addLineView()
        addIngredientsLabel()
    }
    
    private func addTitleLabel() {
        addSubview(titleLabel)
        titleLabel.topToSuperview().constant   = 29
        titleLabel.leftToSuperview().constant  = 15
        titleLabel.rightToSuperview().constant = -58
    }
    
    private func addStackView() {
        addSubview(stackView)
        stackView.topToSuperview().constant   = 15
        stackView.rightToSuperview().constant = -14
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(numberOfPersonLabel)
    }
    
    private func addLineView() {
        addSubview(lineView)
        lineView.topToBottom(of: titleLabel).constant = 29.5
        lineView.leftToSuperview()
        lineView.rightToSuperview()
        lineView.height(1)
    }
    
    private func addIngredientsLabel() {
        addSubview(ingredientsLabel)
        ingredientsLabel.topToBottom(of: lineView).constant = 11.5
        ingredientsLabel.leftToSuperview().constant         = 15
        ingredientsLabel.rightToSuperview().constant        = -15
        ingredientsLabel.bottomToSuperview().constant       = -10
    }
}

// MARK: - Configure and SetLocalize
extension IngredientsView {
    
    private func configureContents() {
        backgroundColor = .appWhite
    }
    
    public func set(viewModel: IngredientsViewProtocol) {
        self.viewModel           = viewModel
        numberOfPersonLabel.text = viewModel.numberOfPerson
        ingredientsLabel.text    = viewModel.ingredients
    }
}
