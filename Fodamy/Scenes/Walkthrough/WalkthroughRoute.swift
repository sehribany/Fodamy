//
//  WalkthroughRoute.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 5.12.2023.
//

protocol WalkthroughRoute {
    func presentWalkthrough()
}

extension WalkthroughRoute where Self: RouterProtocol {
    
    func  presentWalkthrough() {
        let router         = WalkthroughRouter()
        let viewModel      = WalkthroughViewModel(router: router)
        let viewController = WalkthroughViewController(viewModel: viewModel)
        
        let transition        = PlaceOnWindowTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
