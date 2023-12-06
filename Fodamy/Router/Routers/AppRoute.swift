//
//  AppRoute.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 5.12.2023.
//

import MobilliumUserDefaults
import Utilities

final class AppRouter: Router, AppRouter.Routes {
    
    typealias Routes  = WalkthroughRoute & MainTabBarRoute & SKPhotoBrowserRoute
    static let shared = AppRouter()

    func startApp() {
        if DefaultsKey.isIntroCompleted.value == true {
            presentMainTabBar()
        } else {
            presentWalkthrough()
        }
     }
    
    func presentSKPhotoBrowser(with photos: [String], delegate: PhotoBrowserDelegate, initialPageIndex: Int = 0) {
        guard let topVC = topViewController() else { return }
        presentSKPhotoBrowser(with: photos, viewController: topVC, initialPageIndex: initialPageIndex, delegate: delegate)
    }
    
    private func topViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
}
