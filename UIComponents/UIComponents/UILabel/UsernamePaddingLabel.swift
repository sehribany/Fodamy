//
//  UsernamePaddingLabel.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

import UIKit

public class UsernamePaddingLabel: UILabel {
    
    var topInset   : CGFloat
    var bottomInset: CGFloat
    var leftInset  : CGFloat
    var rightInset : CGFloat
    
    required init(withInsets top: CGFloat = 10, _ bottom: CGFloat = 10, _ left: CGFloat = 15, _ right: CGFloat = 6) {
        self.topInset    = top
        self.bottomInset = bottom
        self.leftInset   = left
        self.rightInset  = right
        super.init(frame: CGRect.zero)
        self.layer.masksToBounds
        self.font                = .font(.nunitoBold, size: .xSmall)
        self.textColor           = Asset.Colors.appWhite.color
        self.layer.cornerRadius  = 10
        self.clipsToBounds       = false
        self.layer.masksToBounds = true
        self.backgroundColor     = Asset.Colors.appRed.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    public override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += topInset + bottomInset
        contentSize.width += leftInset + rightInset
        return contentSize
    }
}
