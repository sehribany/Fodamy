//
//  LoadingProtocol.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

import Foundation
import UIKit

public protocol LoadingProtocol {
    func presentLoading()
    func dismissLoading()
}

public extension LoadingProtocol where Self: UIViewController {
    
    func presentLoading() {
        let window = UIApplication.shared.windows.first
        window?.startBlockingActivityIndicator()
    }
    
    func dismissLoading() {
        let window = UIApplication.shared.windows.first
        window?.stopBlockingActivityIndicator()
    }
}
