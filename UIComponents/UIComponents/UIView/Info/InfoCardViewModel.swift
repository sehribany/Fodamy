//
//  InfoCardViewModel.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 8.12.2023.
//

import UIKit

public protocol InfoCardViewDataSource: AnyObject {
    var recipeName      : String { get set }
    var categoryName    : String { get set }
    var difference      : String { get set }
    var commentCount    : Int { get set }
    var likeCount       : Int { get set }
    var commentCountText: NSAttributedString { get set }
    var likeCountText   : NSAttributedString { get set }
}

public protocol InfoCardViewEventSource: AnyObject {}

public protocol InfoCardViewProtocol: InfoCardViewDataSource, InfoCardViewEventSource {}

public final class InfoCardViewModel: InfoCardViewProtocol {
    
    public var recipeName      : String
    public var categoryName    : String
    public var difference      : String
    public var commentCount    : Int
    public var likeCount       : Int
    public var commentCountText: NSAttributedString
    public var likeCountText   : NSAttributedString
    
    public init(recipeName  : String,
                categoryName: String,
                difference  : String,
                commentCount: Int,
                likeCount   : Int) {
        self.recipeName   = recipeName
        self.categoryName = categoryName
        self.difference   = difference
        self.commentCount = commentCount
        self.likeCount    = likeCount
        
        let commentCountText = NSMutableAttributedString()
        commentCountText.append(NSAttributedString(string: "\(commentCount)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.appRed]))
        commentCountText.append(NSAttributedString(string: " ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]))
        commentCountText.append(NSAttributedString(string: L10n.General.comment, attributes: [NSAttributedString.Key.foregroundColor: UIColor.appRaven]))
        self.commentCountText = commentCountText
        
        let likeCountText = NSMutableAttributedString()
        likeCountText.append(NSAttributedString(string: "\(likeCount)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.appRed]))
        likeCountText.append(NSAttributedString(string: " ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]))
        likeCountText.append(NSAttributedString(string: L10n.General.like, attributes: [NSAttributedString.Key.foregroundColor: UIColor.appRaven]))
        self.likeCountText = likeCountText
    }
}
