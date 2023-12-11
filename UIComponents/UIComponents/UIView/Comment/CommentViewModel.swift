//
//  CommentViewModel.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//
import DataProvider

public protocol CommentViewDataSource: AnyObject {
    var comment: Comment { get set }
}

public protocol CommentViewEventSource: AnyObject {}

public protocol CommentViewProtocol: CommentViewDataSource, CommentViewEventSource {}

public final class CommentViewModel: CommentViewProtocol {
    public var comment: Comment
    public init(comment: Comment) {
        self.comment = comment
    }
}
