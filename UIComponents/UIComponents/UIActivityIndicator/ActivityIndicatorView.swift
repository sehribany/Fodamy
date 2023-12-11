//
//  ActivityIndicatorView.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

import UIKit

public class ActivityIndicatorView: UIActivityIndicatorView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        style            = .gray
        tintColor        = .appCinder
        hidesWhenStopped = true
    }
}
