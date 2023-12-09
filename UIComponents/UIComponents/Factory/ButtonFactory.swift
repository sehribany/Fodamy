//
//  ButtonFactory.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 8.12.2023.
//

import MobilliumBuilders

public class ButtonFactory {
    
    public enum Style {
        ///        height 60
        case large
        ///        height 50
        case medium
        ///        height 40
        case small
        
        var height: CGFloat {
            switch self {
            case .large : return 60
            case .medium: return 50
            case .small : return 40
            }
        }
        
        var fontSize: UIFont.FontSize {
            switch self {
            case .large : return .xLarge
            case .medium: return .medium
            case .small : return .medium
            }
        }
    }
    
    public static func createPrimaryButton(style: Style) -> UIButton {
        let button = UIButtonBuilder()
            .titleFont(.font(.nunitoBold, size: style.fontSize))
            .titleColor(.appWhite)
            .backgroundColor(.appRed)
            .cornerRadius(4)
            .build()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: style.height).isActive = true
        button.layer.masksToBounds = true
        button.clipsToBounds       = true
        return button
    }
    
    public static func createPrimaryBorderedButton(style: Style) -> UIButton {
        let button = UIButtonBuilder()
            .titleFont(.font(.nunitoBold, size: style.fontSize))
            .titleColor(.appRed)
            .backgroundColor(.appWhite)
            .cornerRadius(4)
            .borderWidth(2)
            .borderColor(UIColor.appRed.cgColor)
            .build()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: style.height).isActive = true
        button.layer.masksToBounds = true
        button.clipsToBounds      = true
        return button
    }
}
