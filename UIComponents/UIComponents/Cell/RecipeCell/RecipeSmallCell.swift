//
//  RecipeSmallCell.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

import MobilliumBuilders

public class RecipeSmallCell: UICollectionViewCell, ReusableView {
    
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
        .contentMode(.scaleAspectFill)
        .borderWidth(2)
        .build()
    private let usernameLabel  = UsernamePaddingLabel()
    private let labelStackView = UIStackViewBuilder()
        .axis(.vertical)
        .build()
    private let recipeTitleLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .small))
        .textColor(Asset.Colors.appCinder.color)
        .adjustsFontSizeToFitWidth(true)
        .build()
    
    private let recipeCountsLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .small))
        .textColor(Asset.Colors.appRaven.color)
        .build()
    weak var viewModel: RecipeSmallCellProtocol?
    
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
extension RecipeSmallCell {
    
    private func addSubViews() {
        contentView.backgroundColor = .white
        addRecipeImageView()
        addUserImageView()
        addUserNameLabel()
        contentView.bringSubviewToFront(userImageView)
        addRecipeInformationView()
    }
    
    private func addRecipeImageView() {
        contentView.addSubview(recipeImageView)
        recipeImageView.edgesToSuperview(excluding: .bottom)
        recipeImageView.aspectRatio(1)
    }
    
    private func addUserImageView() {
        contentView.addSubview(userImageView)
        userImageView.top(to: recipeImageView).constant     = 5
        userImageView.leading(to: recipeImageView).constant = 5
        userImageView.size(.init(width: 30, height: 30))
    }
    
    private func addUserNameLabel() {
        contentView.addSubview(usernameLabel)
        usernameLabel.leadingToTrailing(of: userImageView).constant = -12
        usernameLabel.centerY(to: userImageView)
        usernameLabel.height(20)
    }
    
    private func addRecipeInformationView() {
        contentView.addSubview(labelStackView)
        labelStackView.topToBottom(of: recipeImageView)
        labelStackView.edgesToSuperview(excluding: .top)
        labelStackView.addArrangedSubview(recipeTitleLabel)
        labelStackView.addArrangedSubview(recipeCountsLabel)
    }
}

// MARK: - Configure and Set Localize
extension RecipeSmallCell {
    
    private func configureContents() {
        backgroundColor = Asset.Colors.appWhite.color
    }
    
    public func set(viewModel: RecipeSmallCellProtocol) {
        self.viewModel      = viewModel
        let recipe          = viewModel.recipe
        let recipeCountText = "\(recipe.commentCount) \(L10n.General.comment) \(recipe.likeCount) \(L10n.General.like)"
        self.recipeImageView.setImageScaled(recipe.images?[0].url)
        self.userImageView.setImageScaled(recipe.user.image?.url)
        self.usernameLabel.text     = recipe.user.username
        self.recipeTitleLabel.text  = recipe.title
        self.recipeCountsLabel.text = recipeCountText
    }
}
