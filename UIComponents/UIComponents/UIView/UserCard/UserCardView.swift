//
//  UserCardView.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 8.12.2023.
//

import Utilities
import MobilliumBuilders

public class UserCardView: UIView {
    
    private let imageView = UIImageViewBuilder()
        .clipsToBounds(true)
        .contentMode(.scaleToFill)
        .cornerRadius(20)
        .build()
    private let stackView = UIStackViewBuilder()
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
    private let followButton = ButtonFactory.createPrimaryBorderedButton(style: .small)
    
    weak var viewModel           : UserCardViewProtocol?
    public var followButtonTapped: VoidClosure?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubViews()
        configure()
    }
}

// MARK: - UILayout
extension UserCardView {
    
    private func addSubViews() {
        addImageView()
        addStackView()
        addFollowButton()
    }
    
    private func addImageView() {
        addSubview(imageView)
        imageView.leftToSuperview().constant   = 15
        imageView.topToSuperview().constant    = 15
        imageView.bottomToSuperview().constant = -15
        imageView.height(40)
        imageView.width(40)
    }
    
    private func addStackView() {
        addSubview(stackView)
        stackView.centerYToSuperview()
        stackView.leftToRight(of: imageView).constant = 10
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(countLabel)
    }
    
    private func addFollowButton() {
        addSubview(followButton)
        followButton.rightToSuperview().constant = -15
        followButton.centerYToSuperview()
        followButton.leftToRight(of: stackView).constant = 10
        followButton.width(120)
    }
}

// MARK: - Configure and SetLocalize
extension UserCardView {
    
    private func configure() {
        backgroundColor = .appWhite
    }
    public func set(viewModel: UserCardViewProtocol) {
        self.viewModel        = viewModel
        imageView.setImage(viewModel.userImageUrl)
        nameLabel.text        = viewModel.username
        countLabel.text       = viewModel.userCountText
        followButton.isHidden = viewModel.followButtonisHidden
        followButton.setTitle(viewModel.followButtonTitle, for: .normal)
        followButton.setTitleColor(viewModel.followButtonSetTitleColor, for: .normal)
        followButton.backgroundColor = viewModel.followButtonBackgroundColor
        followButton.addTarget(self, action: #selector(followButtonAction), for: .touchUpInside)
    }
}
// MARK: - Actions
extension UserCardView {
    @objc
    private func followButtonAction() {
        self.followButtonTapped?()
    }
}
