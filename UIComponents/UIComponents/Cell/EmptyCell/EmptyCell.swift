//
//  EmptyCell.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

import UIKit
import MobilliumBuilders

public class EmptyCell: UICollectionViewCell, ReusableView {
    
    private let infoLabel = UILabelBuilder()
        .textAlignment(.center)
        .numberOfLines(0)
        .font(.font(.nunitoSemiBold, size: .xLarge))
        .textColor(.appRaven)
        .text(L10n.Modules.RecipeDetail.noComment)
        .build()
    
    private lazy var width: NSLayoutConstraint = {
        let width      = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    weak var viewModel: EmptyCellProtocol?
    
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
    
    public override func systemLayoutSizeFitting(_ targetSize: CGSize,
                                                 withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
                                                 verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
}

// MARK: - UILayout
extension EmptyCell {
    private func addSubViews() {
        contentView.addSubview(infoLabel)
        infoLabel.edgesToSuperview(insets: UIEdgeInsets(top: 50, left: 20, bottom: 50, right: 20))    }
}

// MARK: - Configure and Localize
extension EmptyCell {
    private func configureContents() {
        contentView.backgroundColor = .appWhite
    }
}
