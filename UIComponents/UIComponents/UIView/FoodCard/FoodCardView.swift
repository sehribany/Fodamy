//
//  FoodCardView.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

import UIKit
import MobilliumBuilders

public class FoodCardView: UIView {

    private let userImageView = UIImageViewBuilder()
        .clipsToBounds(true)
        .contentMode(.scaleToFill)
        .cornerRadius(20)
        .build()
    private let userStackView = UIStackViewBuilder()
        .axis(.vertical)
        .spacing(0)
        .build()
    private let nameLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .medium))
        .textColor(.appCinder)
        .textAlignment(.left)
        .build()
    private let countLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .medium))
        .textColor(.appRaven)
        .textAlignment(.left)
        .build()
    private let lineView = UIViewBuilder()
        .backgroundColor(.appZircon)
        .build()
    private let recipeStackView = UIStackViewBuilder()
        .axis(.vertical)
        .spacing(0)
        .build()
    private let titleLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .xLarge))
        .textColor(.appCinder)
        .textAlignment(.left)
        .build()
    private let categoryNameLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .xLarge))
        .textColor(.appRaven)
        .textAlignment(.left)
        .build()
    private let recipeImageView = UIImageViewBuilder()
        .build()
    private let recipeCountLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .medium))
        .textColor(.appRaven)
        .textAlignment(.left)
        .build()
    private let badgeImageView = UIImageViewBuilder()
        .clipsToBounds(true)
        .contentMode(.center)
        .cornerRadius(20)
        .image(.imgEditorsPick)
        .backgroundColor(.appWhite)
        .build()
    weak var viewModel: FoodCardViewProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubViews()
    }
}

//MARK: - UILayout
extension FoodCardView{
    private func addSubViews(){
        addImageView()
        addStackView()
        addLineView()
        addRecipeStackView()
        addRecipeImageView()
        addRecipeCountLabel()
        addBadgeImageView()
    }
    
    private func addImageView(){
        addSubview(userImageView)
        userImageView.leftToSuperview().constant = 15
        userImageView.topToSuperview().constant  = 15
        userImageView.height(40)
        userImageView.width(40)
    }
    
    private func addStackView() {
        addSubview(userStackView)
        userStackView.topToSuperview().constant               = 17
        userStackView.leftToRight(of: userImageView).constant = 10
        userStackView.rightToSuperview().constant             = -15
        userStackView.addArrangedSubview(nameLabel)
        userStackView.addArrangedSubview(countLabel)
    }
    
    private func addLineView() {
        addSubview(lineView)
        lineView.leftToSuperview()
        lineView.rightToSuperview()
        lineView.topToBottom(of: userImageView).constant = 15
        lineView.height(1)
    }
    
    private func addRecipeStackView() {
        addSubview(recipeStackView)
        recipeStackView.topToBottom(of: lineView).constant = 11.5
        recipeStackView.leftToSuperview().constant         = 15
        recipeStackView.rightToSuperview().constant        = -15
        recipeStackView.addArrangedSubview(titleLabel)
        recipeStackView.addArrangedSubview(categoryNameLabel)
    }
    
    private func addRecipeImageView() {
        addSubview(recipeImageView)
        recipeImageView.leftToSuperview().constant                = 15
        recipeImageView.rightToSuperview().constant               = -15
        recipeImageView.aspectRatio(1)
        recipeImageView.topToBottom(of: recipeStackView).constant = 10
    }
    
    private func addRecipeCountLabel() {
        addSubview(recipeCountLabel)
        recipeCountLabel.topToBottom(of: recipeImageView).constant = 13
        recipeCountLabel.leftToSuperview().constant                = 15
        recipeCountLabel.rightToSuperview().constant               = -15
    }
    
    private func addBadgeImageView() {
        addSubview(badgeImageView)
        badgeImageView.rightToSuperview().constant               = -30
        badgeImageView.topToBottom(of: recipeStackView).constant = 25
        badgeImageView.height(40)
        badgeImageView.width(40)
    }
}
// MARK: - Configure and Set Localize
extension FoodCardView {
    public func set(viewModel: FoodCardViewProtocol) {
        self.viewModel          = viewModel
        let recipe              = viewModel.recipe
        let userCountText       = "\(viewModel.recipe.user.recipeCount) \(L10n.General.recipe) \(viewModel.recipe.user.followingCount) \(L10n.General.follower)"
        let recipeCountText     = "\(viewModel.recipe.commentCount) \(L10n.General.comment) \(recipe.likeCount) \(L10n.General.like)"
        userImageView.setImage(recipe.user.image?.url)
        nameLabel.text          = recipe.user.username
        countLabel.text         = userCountText
        titleLabel.text         = recipe.title
        categoryNameLabel.text  = recipe.category.name
        recipeImageView.setImage(recipe.images?[0].url)
        recipeCountLabel.text   = recipeCountText
        badgeImageView.isHidden = !recipe.isEditorChoice
    }
}
