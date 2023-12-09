//
//  ReusableView+Extensions.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

import UIKit

public extension ReusableView where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}
