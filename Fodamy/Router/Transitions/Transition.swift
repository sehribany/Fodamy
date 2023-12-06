//
//  Transition.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 5.12.2023.
//

import UIKit

protocol Transition: AnyObject {
    var viewController: UIViewController? { get set }
    func open(_ viewController: UIViewController)
    func close(_ viewController: UIViewController)
}
