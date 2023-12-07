//
//  ToastWarningView.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 5.12.2023.
//

import MobilliumBuilders
import TinyConstraints

class ToastWarningView: UIView {
    
    private let label = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .large))
        .textColor(.appWhite)
        .textAlignment(.center)
        .numberOfLines(0)
        .build()
    
    init(text: String) {
        label.text = text
        label.sizeToFit()
        super.init(frame: .zero)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContents() {
        addSubview(label)
        label.height(44)
        label.topToSuperview()
        label.bottomToSuperview()
        label.leadingToSuperview().constant = 55
        label.trailingToSuperview().constant = -55
        label.baselineAdjustment = .alignCenters
    }
}
