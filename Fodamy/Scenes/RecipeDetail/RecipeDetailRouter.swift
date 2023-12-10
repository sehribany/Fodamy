//
//  RecipeDetailRouter.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

final class RecipeDetailRouter: Router, RecipeDetailRouter.Routes {
    typealias Routes =
    LoginWarningPopupRoute &
    LoginRoute &
    UnfollowAlertViewRoute &
    ShareSheetRoute &
    CommentListRoute
}
