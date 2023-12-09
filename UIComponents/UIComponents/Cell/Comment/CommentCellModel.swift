//
//  CommentCellModel.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 8.12.2023.
//

import Utilities

public protocol CommentCellDataSource: AnyObject {
    var userId        : Int { get }
    var imageUrl      : String? { get }
    var username      : String? { get }
    var differenceText: String? { get }
    var commentId     : Int { get }
    var commentText   : String? { get set }
    var isOwner       : Bool { get set }
    var recipeCount   : Int { get }
    var followedCount : Int { get }
    var isFollowing   : Bool { get set }
}

public protocol CommentCellEventSource: AnyObject {
    var moreButtonTapped     : VoidClosure? { get set }
    var commentTextDidChanged: VoidClosure? { get set }
}

public protocol CommentCellProtocol: CommentCellDataSource, CommentCellEventSource {}

public final class CommentCellModel: CommentCellProtocol {
    public var isFollowing          : Bool
    public var recipeCount          : Int
    public var followedCount        : Int
    public var userId               : Int
    public var imageUrl             : String?
    public var username             : String?
    public var differenceText       : String?
    public var commentId            : Int
    public var commentText          : String?
    public var isOwner              : Bool
    public var moreButtonTapped     : VoidClosure?
    public var commentTextDidChanged: VoidClosure?

    public init(userId        : Int,
                imageUrl      : String?,
                username      : String?,
                recipeCount   : Int,
                followedCount : Int,
                differenceText: String?,
                commentId     : Int,
                commentText   : String?,
                isOwner       : Bool,
                isFollowing   : Bool) {
        self.userId         = userId
        self.imageUrl       = imageUrl
        self.username       = username
        self.recipeCount    = recipeCount
        self.followedCount  = followedCount
        self.differenceText = differenceText
        self.commentId      = commentId
        self.commentText    = commentText
        self.isOwner        = isOwner
        self.isFollowing    = isFollowing
    }
}

