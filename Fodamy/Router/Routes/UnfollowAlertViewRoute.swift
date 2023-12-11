//
//  UnfollowAlertViewRoute.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//
import UIKit

protocol UnfollowAlertViewRoute {
    func presentUnfollowAlertView(unFollowAction: VoidClosure?)
}

extension UnfollowAlertViewRoute where Self: RouterProtocol {
    
    func presentUnfollowAlertView(unFollowAction: VoidClosure?) {
        let transition     = ModalTransition()
        let alert          = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let unFollowAction = UIAlertAction(title: "Takibi Bırak", style: .destructive) {_ in
            unFollowAction?()
        }
        let dismissAction = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
        
        alert.addAction(unFollowAction)
        alert.addAction(dismissAction)
        
        open(alert, transition: transition)
    }
}
