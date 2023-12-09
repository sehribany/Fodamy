//
//  InfoCardView.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 8.12.2023.
//

import MobilliumBuilders
import Utilities

public class InfoCardView: UIView {
    private let recipeView = UIViewBuilder()
        .backgroundColor(.appWhite)
        .build()
    private let recipeStackView = UIStackViewBuilder()
        .axis(.horizontal)
        .spacing(0)
        .alignment(.fill)
        .distribution(.fill)
        .build()
    private let labelStackView = UIStackViewBuilder()
        .axis(.vertical)
        .spacing(0)
        .alignment(.leading)
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
    private let differenceLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .medium))
        .textColor(.appRaven)
        .textAlignment(.right)
        .build()
    private let lineView = UIViewBuilder()
        .backgroundColor(.appZircon)
        .build()
    private let countView = UIViewBuilder()
        .backgroundColor(.appZircon)
        .build()
    private let countStackView = UIStackViewBuilder()
        .axis(.horizontal)
        .alignment(.fill)
        .spacing(1)
        .distribution(.fillProportionally)
        .build()
    private let commentView = UIViewBuilder()
        .backgroundColor(.appWhite)
        .build()
    private let commentStackView = UIStackViewBuilder()
        .axis(.vertical)
        .spacing(7)
        .alignment(.center)
        .distribution(.fill)
        .build()
    private let commentButton = UIButtonBuilder()
        .image(.icComment)
        .tintColor(.appCinder)
        .build()
    private let commentLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .medium))
        .textColor(.appRaven)
        .textAlignment(.center)
        .build()
    private let likeView = UIViewBuilder()
        .backgroundColor(.appWhite)
        .build()
    private let likeStackView = UIStackViewBuilder()
        .axis(.vertical)
        .spacing(7)
        .alignment(.center)
        .distribution(.fill)
        .build()
    private let likeButton = UIButtonBuilder()
        .image(.icHeart)
        .tintColor(.appCinder)
        .build()
    private let likeLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .medium))
        .textColor(.appRaven)
        .textAlignment(.center)
        .build()
    
    weak var viewModel         : InfoCardViewProtocol?
    public var infoButtonTapped: VoidClosure?
    
    public var likeButtonColor: UIColor? {
        willSet {
            likeButton.tintColor = newValue
        }
    }

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
extension InfoCardView {
    
    private func addSubViews() {
        addRecipeView()
        addRecipeStackView()
        addLabelStackView()
        addLineView()
        addCountView()
        addCountStackView()
        addCommentStackView()
        addLikeStackView()
    }
    private func addRecipeView() {
        addSubview(recipeView)
        recipeView.leftToSuperview()
        recipeView.rightToSuperview()
        recipeView.topToSuperview()
    }
    private func addRecipeStackView() {
        recipeView.addSubview(recipeStackView)
        recipeStackView.leftToSuperview().constant = 15
        recipeStackView.rightToSuperview().constant = -15
        recipeStackView.topToSuperview().constant = 10
        recipeStackView.bottomToSuperview().constant = -10.5
        recipeStackView.addArrangedSubview(labelStackView)
        recipeStackView.addArrangedSubview(differenceLabel)
    }
    private func addLabelStackView() {
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(categoryNameLabel)
    }
    private func addLineView() {
        addSubview(lineView)
        lineView.topToBottom(of: recipeView)
        lineView.leftToSuperview()
        lineView.rightToSuperview()
        lineView.height(1)
    }

    private func addCountStackView() {
        countView.addSubview(countStackView)
        countStackView.edgesToSuperview()
        countStackView.addArrangedSubview(commentView)
        countStackView.addArrangedSubview(likeView)
    }
    private func addCommentStackView() {
        commentView.addSubview(commentStackView)
        commentStackView.centerXToSuperview()
        commentStackView.topToSuperview().constant = 15.5
        commentStackView.bottomToSuperview().constant = -10
        commentStackView.addArrangedSubview(commentButton)
        commentStackView.addArrangedSubview(commentLabel)
    }
    private func addCountView() {
        addSubview(countView)
        countView.topToBottom(of: lineView)
        countView.leftToSuperview()
        countView.rightToSuperview()
        countView.bottomToSuperview().constant = 0
    }
    private func addLikeStackView() {
        likeView.addSubview(likeStackView)
        likeStackView.centerXToSuperview()
        likeStackView.topToSuperview().constant = 15.5
        likeStackView.bottomToSuperview().constant = -10
        likeStackView.addArrangedSubview(likeButton)
        likeStackView.addArrangedSubview(likeLabel)
    }
}

// MARK: - Configure and SetLocalize
extension InfoCardView {

    private func configureContents() {
        backgroundColor = .appWhite
        commentButton.size(CGSize(width: 20, height: 18))
        likeButton.size(CGSize(width: 20, height: 18))
        commentButton.addTarget(self, action: #selector(infoButtonsTapped), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(infoButtonsTapped), for: .touchUpInside)
    }
    
    public func set(viewModel: InfoCardViewProtocol) {
        self.viewModel              = viewModel
        titleLabel.text             = viewModel.recipeName
        categoryNameLabel.text      = viewModel.categoryName
        differenceLabel.text        = viewModel.difference
        commentLabel.attributedText = viewModel.commentCountText
        likeLabel.attributedText    = viewModel.likeCountText
    }
}

// MARK: - Actions
extension InfoCardView {
    @objc
    private func infoButtonsTapped() {
        self.infoButtonTapped?()
    }
}
