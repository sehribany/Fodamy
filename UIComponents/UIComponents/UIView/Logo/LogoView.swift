//
//  LogoView.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

import UIKit
import MobilliumBuilders

public class LogoView: UIView {
    
    private let imageView = UIImageViewBuilder()
        .contentMode(.scaleAspectFit)
        .build()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureContents()
    }
    
    private func configureContents() {
        addSubview(imageView)
        imageView.image = .imgLogoFodamy
        imageView.centerXToSuperview()
        imageView.centerYToSuperview()
        imageView.height(30)
        imageView.width(110)
    }
}
