//
//  FavoriteCardView.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

import UIKit
import MobilliumBuilders

public class FavoriteCardView: UIView {
    
    private let recipeImageView = UIImageViewBuilder()
        .contentMode(.scaleAspectFill)
        .clipsToBounds(true)
        .build()
    private let userImageView = UIImageViewBuilder()
        .backgroundColor(.appWhite)
        .cornerRadius(15)
        .size(.init(width: 30, height: 30))
        .clipsToBounds(true)
        .masksToBounds(true)
        .borderColor(UIColor.appRed.cgColor)
        .build()
    private let usernameLabel = UsernamePaddingLabel()
    private let labelStackView = UIStackViewBuilder()
        .axis(.vertical)
        .build()
    private let recipeTitleLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .small))
        .textColor(.appCinder)
        .adjustsFontSizeToFitWidth(true)
        .build()
    private let recipeCountsLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .small))
        .textColor(.appRaven)
        .build()
    weak var viewModel: FavoriteCardViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        configureContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubViews()
        configureContents()
    }
}

// MARK: - UILayout
extension FavoriteCardView {
    
    private func addSubViews() {
        addRecipeImageView()
        addUserNameLabel()
        addUserImageView()
        addLabelStackView()
    }
    
    private func addRecipeImageView() {
        addSubview(recipeImageView)
        recipeImageView.edgesToSuperview(excluding: .bottom)
        recipeImageView.aspectRatio(1)
    }
    
    private func addUserNameLabel() {
        addSubview(usernameLabel)
        usernameLabel.leftToSuperview().constant = 23
        usernameLabel.topToSuperview().constant = 5
        usernameLabel.height(20)
    }
    
    private func addUserImageView() {
        addSubview(userImageView)
        userImageView.topToSuperview().constant = 10
        userImageView.centerY(to: usernameLabel)
        userImageView.leftToSuperview().constant = 5
        userImageView.size(.init(width: 30, height: 30))
    }
    
    private func addLabelStackView() {
        addSubview(labelStackView)
        labelStackView.topToBottom(of: recipeImageView)
        labelStackView.leadingToSuperview().constant = 10
        labelStackView.trailingToSuperview().constant = -10
        labelStackView.bottomToSuperview()
        labelStackView.addArrangedSubview(recipeTitleLabel)
        labelStackView.addArrangedSubview(recipeCountsLabel)
    }
}

// MARK: - Configure and Set Localize
extension FavoriteCardView {
    
    private func configureContents() {
        backgroundColor = .appWhite
    }
    
    public func set(viewModel: FavoriteCardViewProtocol) {
        self.viewModel = viewModel
        let recipe = viewModel.recipe
        let recipeCountText = "\(recipe.commentCount) \(L10n.General.comment) \(recipe.likeCount) \(L10n.General.like)"
        self.recipeImageView.setImageScaled(recipe.images?[0].url)
        self.userImageView.setImageScaled(recipe.user.image?.url)
        self.usernameLabel.text = recipe.user.username
        self.recipeTitleLabel.text = recipe.title
        self.recipeCountsLabel.text = recipeCountText
    }
}
