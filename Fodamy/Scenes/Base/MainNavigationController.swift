//
//  MainNavigationController.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 5.12.2023.
//

import UIKit
import UIComponents
import MobilliumBuilders

class MainNavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
    }
    
    private func configureContents() {
        let backImage = Asset.Icons.icBack.image
            .resize(to: .init(width: 11, height: 18))
            .withRenderingMode(.alwaysTemplate)
            .withAlignmentRectInsets(.init(top: 0, left: 0, bottom: -2, right: 0))
        let titleTextAttributes = AttributedStringDictionaryBuilder()
            .font(.font(.nunitoExtraBold, size: .medium))
            .foregroundColor(Asset.Colors.appWhite.color)
            .build()
        navigationBar.barTintColor        = Asset.Colors.appRed.color
        navigationBar.shadowImage         = UIImage()
        navigationBar.tintColor           = Asset.Colors.appWhite.color
        navigationBar.titleTextAttributes = titleTextAttributes
        UIBarButtonItem.appearance().setTitleTextAttributes(AttributedStringDictionaryBuilder()
                                                                .font(.font(.nunitoSemiBold, size: .large))
                                                                .foregroundColor(Asset.Colors.appWhite.color)
                                                                .build(),
                                                            for: .normal)

        navigationBar.backIndicatorImage               = backImage
        navigationBar.backIndicatorTransitionMaskImage = backImage
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowColor         = .clear
            appearance.backgroundColor     = Asset.Colors.appRed.color
            appearance.titleTextAttributes = titleTextAttributes
            appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
            navigationBar.standardAppearance   = appearance
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.compactAppearance    = appearance
        }
        navigationBar.backItem?.backBarButtonItem?.setTitlePositionAdjustment(.init(horizontal: 0, vertical: -13), for: .default)
    }
}
