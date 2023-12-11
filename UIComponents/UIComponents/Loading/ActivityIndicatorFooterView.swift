//
//  ActivityIndicatorFooterView.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

import UIKit

public class ActivityIndicatorFooterView: UICollectionReusableView, ReusableView {
    
    public let activityIndicator = ActivityIndicatorView(frame: .infinite)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
    }

    private func setupConstraints() {
        addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
    }
}
