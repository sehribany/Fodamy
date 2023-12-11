//
//  CommentEditDeleteAlertViewRoute.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

import UIKit

protocol CommentEditDeleteAlertViewRoute {
    func presentCommentEditDeleteAlertView(edit: VoidClosure?, delete: VoidClosure?)
}

extension CommentEditDeleteAlertViewRoute where Self: RouterProtocol {
    func presentCommentEditDeleteAlertView(edit: VoidClosure?, delete: VoidClosure?) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let edit = UIAlertAction(title: L10n.Modules.CommentEditController.title, style: .default) { _ in
            edit?()
        }
        let delete = UIAlertAction(title: "sil", style: .destructive) { _ in
            delete?()
        }
        let cancel = UIAlertAction(title: "iptal", style: .cancel, handler: nil)
        let transition = ModalTransition()
        
        alert.addAction(edit)
        alert.addAction(delete)
        alert.addAction(cancel)
        
        open(alert, transition: transition)
    }
}
