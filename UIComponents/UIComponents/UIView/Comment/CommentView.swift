//
//  CommentView.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

import UIKit
import MobilliumBuilders

public class CommentView: UIView {
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
    private let differenceLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .xSmall))
        .textColor(.appRaven)
        .textAlignment(.left)
        .build()
    private let commentLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .medium))
        .textColor(.appCinder)
        .textAlignment(.left)
        .numberOfLines(0)
        .build()
    weak var viewModel: CommentViewProtocol?
    
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
extension CommentView {
    private func addSubViews() {
        addImageView()
        addStackView()
        addDifferenceLabel()
        addCommentLabel()
    }
    
    private func addImageView() {
        addSubview(userImageView)
        userImageView.leftToSuperview().constant = 15
        userImageView.topToSuperview().constant = 15
        userImageView.height(40)
        userImageView.width(40)
    }
    
    private func addStackView() {
        addSubview(userStackView)
        userStackView.topToSuperview().constant = 17
        userStackView.leftToRight(of: userImageView).constant = 10
        userStackView.rightToSuperview().constant = -15
        userStackView.addArrangedSubview(nameLabel)
        userStackView.addArrangedSubview(countLabel)
    }
    
    private func addDifferenceLabel() {
        addSubview(differenceLabel)
        differenceLabel.topToBottom(of: userStackView).constant = 12
        differenceLabel.leftToSuperview().constant = 15
        differenceLabel.rightToSuperview().constant = -15
    }
    
    private func addCommentLabel() {
        addSubview(commentLabel)
        commentLabel.topToBottom(of: differenceLabel).constant = 7
        commentLabel.leftToSuperview().constant = 15
        commentLabel.rightToSuperview().constant = -15
        commentLabel.bottomToSuperview().constant = -4
    }
    
}
// MARK: - Configure and Set Localize
extension CommentView {
    private func configureContents() {
        backgroundColor = .appWhite
    }
    
    public func set(viewModel: CommentViewProtocol) {
        self.viewModel       = viewModel
        let comment          = viewModel.comment
        let userCountText    = "\(viewModel.comment.user.recipeCount) \(L10n.General.recipe) \(viewModel.comment.user.followingCount) \(L10n.General.follower)"
        userImageView.setImage(comment.user.image?.url)
        nameLabel.text       = comment.user.username
        countLabel.text      = userCountText
        differenceLabel.text = comment.difference
        commentLabel.text    = comment.text
    }
}
