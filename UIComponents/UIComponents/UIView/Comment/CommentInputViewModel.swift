//
//  CommentInputViewModel.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

public protocol CommentInputViewDataSource: AnyObject {}

public protocol CommentInputViewEventSource: AnyObject {}

public protocol CommentInputViewProtocol: CommentInputViewDataSource, CommentInputViewEventSource {}

public final class CommentInputViewModel: CommentInputViewProtocol {}
