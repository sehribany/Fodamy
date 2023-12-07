//
//  PageController.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 6.12.2023.
//

import UIKit

public class PageControl: UIPageControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContents() {
        tintColor                     = Asset.Colors.appRed.color
        pageIndicatorTintColor        = Asset.Colors.appRed.color.withAlphaComponent(0.3)
        currentPageIndicatorTintColor = Asset.Colors.appRed.color
    }
}
