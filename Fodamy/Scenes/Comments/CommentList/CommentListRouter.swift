//
//  CommentListRouter.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

final class CommentListRouter: Router, CommentListRouter.Routes {
    typealias Routes =
    LoginWarningPopupRoute &
    LoginRoute &
    CommentEditDeleteAlertViewRoute &
    CommentEditRoute
}
