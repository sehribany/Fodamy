//
//  ActivityIndicatorProtocol.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

import Foundation
import TinyConstraints

public protocol ActivityIndicatorProtocol {
    func showActivityIndicator()
    func hideActivityIndicator()
}

public extension ActivityIndicatorProtocol where Self: UIViewController {
    func showActivityIndicator() {
        let indicator = ActivityIndicatorView(frame: .infinite)
        indicator.startAnimating()
        view.addSubview(indicator)
        indicator.centerInSuperview()
        view.bringSubviewToFront(indicator)
    }
    
    func hideActivityIndicator() {
        view.subviews.filter({ $0 is ActivityIndicatorView }).forEach({ $0.removeFromSuperview() })
    }
}
