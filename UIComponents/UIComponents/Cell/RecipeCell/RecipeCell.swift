//
//  RecipeCell.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

import UIKit
import DataProvider

public class RecipeCell: UICollectionViewCell, ReusableView {
    
    private let foodCard = FoodCardView()

    weak var viewModel: RecipeCellProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureContents()
    }
    
    private func configureContents() {
        addSubview(foodCard)
        backgroundColor = .appWhite
        foodCard.edgesToSuperview()
    }
    
    public func set(viewModel: RecipeCellProtocol) {
        self.viewModel = viewModel
        foodCard.set(viewModel: FoodCardViewModel(recipe: viewModel.recipe))
    }
}
