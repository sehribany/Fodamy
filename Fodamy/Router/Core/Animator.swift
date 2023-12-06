//
//  Animator.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 5.12.2023.
//

import UIKit

protocol Animator: UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool { get set }
}
