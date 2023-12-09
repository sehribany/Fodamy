//
//  RecipeDetailViewController.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

import UIKit
import MobilliumBuilders

final class RecipeDetailViewController: BaseViewController<RecipeDetailViewModel> {
    
    private let imageSliderView = ImageSliderView()
    private let scrollView = UIScrollViewBuilder()
        .showsHorizontalScrollIndicator(false)
        .showsVerticalScrollIndicator(false)
        .alwaysBounceVertical(false)
        .build()
    private let contentStackView = UIStackViewBuilder()
        .axis(.vertical)
        .spacing(15)
        .build()
    private let infoView = InfoCardView()
    private let countInfoStackView = UIStackViewBuilder()
        .axis(.horizontal)
        .spacing(1)
        .distribution(.fillEqually)
        .build()
    private let userCardView = UserCardView()


    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
    }
}
// MARK: - UILayout
extension RecipeDetailViewController {
    
    private func addSubViews() {
        addScrollView()
        addContentStackView()
        configureContents()
    }
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.edgesToSuperview(excluding: .top)
        scrollView.topToSuperview(usingSafeArea: true)
    }
    private func addContentStackView() {
        scrollView.addSubview(contentStackView)
        contentStackView.widthToSuperview()
        contentStackView.edgesToSuperview()
        
        contentStackView.addArrangedSubview(imageSliderView)
        contentStackView.setCustomSpacing(0, after: imageSliderView)
        imageSliderView.aspectRatio(1)
    }
}

// MARK: - Configure and Set Localize
extension RecipeDetailViewController {
    
    private func configureContents() {
        title                = viewModel.recipe.title
        view.backgroundColor = Asset.Colors.appSecondaryBackground.color
    }
}
