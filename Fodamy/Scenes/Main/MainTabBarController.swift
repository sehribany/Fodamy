//
//  MainTabBarControllerViewController.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 5.12.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = Asset.Colors.appRed.color
        
        let homeViewController      = createHomeViewController()
        let favoritesViewController = createFavoritesViewController()
        viewControllers             = [homeViewController, favoritesViewController]

    }
    
    private func configureTabBarIcons(navController: MainNavigationController, icon:UIImage?) {
        navController.tabBarItem.image = icon
        
    }
    private func configureContents() {
        tabBar.tintColor = Asset.Colors.appRed.color
    }
    private func createHomeViewController() -> UINavigationController {
        let homeRouter         = HomeRouter()
        let homeViewModel      = HomeViewModel(router: homeRouter)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        let navController      = MainNavigationController(rootViewController: homeViewController)
        configureTabBarIcons(navController: navController, icon: Asset.Icons.icHome.image)
        homeRouter.viewController = homeViewController
        return navController
    }
    
    private func createFavoritesViewController() -> UINavigationController {
        let favoritesRouter         = FavoritesRouter()
        let favoritesViewModel      = FavoritesViewModel(router: favoritesRouter)
        let favoritesViewController = FavoritesViewController(viewModel: favoritesViewModel)
        let navController           = MainNavigationController(rootViewController: favoritesViewController)
        configureTabBarIcons(navController: navController, icon: Asset.Icons.icHeart.image)
        favoritesRouter.viewController = favoritesViewController
        return navController
    }
    


}
