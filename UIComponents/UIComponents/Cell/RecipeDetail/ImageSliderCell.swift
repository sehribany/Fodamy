//
//  ImageSliderCell.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 8.12.2023.
//

import UIKit
import MobilliumBuilders

public class ImageSliderCell: UICollectionViewCell, ReusableView {
    
    private let imageView = UIImageViewBuilder()
        .backgroundColor(.clear)
        .contentMode(.scaleAspectFill)
        .clipsToBounds(true)
        .build()
    private let badgeImageView = UIImageViewBuilder()
        .clipsToBounds(true)
        .contentMode(.center)
        .cornerRadius(20)
        .image(.imgEditorsPick)
        .backgroundColor(.appWhite)
        .shadowColor(UIColor.appCinder.cgColor)
        .shadowOpacity(0.40)
        .shadowOffset(.zero)
        .shadowRadius(4)
        .build()
    weak var viewModel: ImageSliderCellProtocol?
    
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
extension ImageSliderCell {
    
    private func addSubViews() {
        addImageView()
        addBadgeImageView()
    }
    
    private func addImageView() {
        addSubview(imageView)
        imageView.edgesToSuperview()
    }
    
    private func addBadgeImageView() {
        addSubview(badgeImageView)
        badgeImageView.rightToSuperview().constant = -15
        badgeImageView.topToSuperview().constant = 15
        badgeImageView.height(40)
        badgeImageView.width(40)
    }
}

// MARK: - Configure and Set Localize
extension ImageSliderCell {
    
    private func configureContents() {
//        imageView.setImage(self.viewModel?.imageUrl)
//        badgeImageView.isHidden = !(self.viewModel?.isEditorChoice ?? false)
    }
    
    public func set(viewModel: ImageSliderCellProtocol) {
        self.viewModel = viewModel
        imageView.setImage(viewModel.imageUrl)
        badgeImageView.isHidden = !viewModel.isEditorChoice
    }

}
