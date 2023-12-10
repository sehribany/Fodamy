//
//  StepsView.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

import UIKit
import MobilliumBuilders

public class StepsView: UIView {
    
    private let titleLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .xLarge))
        .textColor(.appCinder)
        .textAlignment(.left)
        .text(L10n.General.recipeSteps)
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
    private let timeOfRecipeLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .small))
        .textColor(.appRaven)
        .build()
    private let lineView = UIViewBuilder()
        .backgroundColor(.appZircon)
        .build()
    private let drectionsLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .xLarge))
        .textColor(.appCinder)
        .numberOfLines(0)
        .build()
    weak var viewModel: StepsViewProtocol?
    
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
extension StepsView {
    
    private func addSubViews() {
        addTitleLabel()
        addStackView()
        addLineView()
        addStepsLabel()
    }
    
    private func addTitleLabel() {
        addSubview(titleLabel)
        titleLabel.topToSuperview().constant = 29
        titleLabel.leftToSuperview().constant = 15
        titleLabel.rightToSuperview().constant = -58
    }
    
    private func addStackView() {
        addSubview(stackView)
        stackView.topToSuperview().constant = 15
        stackView.rightToSuperview().constant = -14
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(timeOfRecipeLabel)
    }
    
    private func addLineView() {
        addSubview(lineView)
        lineView.topToBottom(of: titleLabel).constant = 29.5
        lineView.leftToSuperview()
        lineView.rightToSuperview()
        lineView.height(1)
    }
    
    private func addStepsLabel() {
        addSubview(drectionsLabel)
        drectionsLabel.topToBottom(of: lineView).constant = 11.5
        drectionsLabel.leftToSuperview().constant = 15
        drectionsLabel.rightToSuperview().constant = -15
        drectionsLabel.bottomToSuperview().constant = -10
    }
}

// MARK: - Configure and SetLocalize
extension StepsView {
    
    private func configureContents() {
        backgroundColor = .appWhite
    }
    
    public func set(viewModel: StepsViewProtocol) {
        self.viewModel = viewModel
        timeOfRecipeLabel.text = "\(viewModel.timeOfRecipe) dk"
        drectionsLabel.text = viewModel.directions
    }
}
