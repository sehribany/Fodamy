//
//  CommentCell.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 8.12.2023.
//

import MobilliumBuilders

public class CommentCell: UICollectionViewCell, ReusableView {
    
    private let userCardView = UserCardView()
    private let timeDifferenceLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .xSmall))
        .textColor(.appRaven)
        .build()
    private let commentLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .medium))
        .textColor(.appCinder)
        .numberOfLines(0)
        .build()
    private let moreButton = UIButtonBuilder()
        .backgroundColor(.clear)
        .image(UIImage.icMore.withRenderingMode(.alwaysTemplate))
        .tintColor(.appCinder)
        .build()
    weak var viewModel: CommentCellProtocol?
    
    public var isMoreButtonHidden: Bool? {
        willSet {
            moreButton.isHidden = newValue ?? false
        }
    }
    
    private lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubViews()
    }
    
    public override func systemLayoutSizeFitting(_ targetSize: CGSize,
                                                 withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
                                                 verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
}

// MARK: - UILayout
extension CommentCell {
    
    private func addSubViews() {
        backgroundColor = .white
        contentView.addSubview(userCardView)
        userCardView.topToSuperview()
        userCardView.leftToSuperview()
        userCardView.rightToSuperview()
        userCardView.height(70)
        
        contentView.addSubview(timeDifferenceLabel)
        timeDifferenceLabel.topToBottom(of: userCardView)
        timeDifferenceLabel.leadingToSuperview().constant  = 15
        timeDifferenceLabel.trailingToSuperview().constant = -15
        
        contentView.addSubview(commentLabel)
        commentLabel.topToBottom(of: timeDifferenceLabel).constant = 7
        commentLabel.edgesToSuperview(excluding: .top, insets: UIEdgeInsets(top: 0, left: 15, bottom: 5, right: 15))
        
        contentView.addSubview(moreButton)
        moreButton.topToSuperview(offset: 10)
        moreButton.trailingToSuperview(offset: 15)
        moreButton.leadingToTrailing(of: userCardView).constant = 15
        moreButton.size(CGSize(width: 18, height: 10))
        moreButton.addTarget(self, action: #selector(moreButtonTapped(_:)), for: .touchUpInside)
    }
}

// MARK: - Actions
extension CommentCell {
    @objc
    private func moreButtonTapped(_ sender: UIButton) {
        viewModel?.moreButtonTapped?()
    }
}

// MARK: - Set ViewModel
public extension CommentCell {
    
    func set(viewModel: CommentCellProtocol) {
        self.viewModel = viewModel
        userCardView.set(viewModel: UserCardViewModel(userId: viewModel.userId,
                                                      userImageUrl: viewModel.imageUrl,
                                                      username: viewModel.username,
                                                      isfollowing: viewModel.isFollowing,
                                                      recipeCount: viewModel.recipeCount,
                                                      followedCount: viewModel.followedCount,
                                                      followButtonisHidden: true))
        self.timeDifferenceLabel.text         = viewModel.differenceText
        self.commentLabel.text                = viewModel.commentText
        self.moreButton.isHidden              = !viewModel.isOwner
        self.viewModel?.commentTextDidChanged = { [weak self] in
            self?.commentLabel.text = self?.viewModel?.commentText
        }
    }
}
