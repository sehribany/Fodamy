//
//  WalkthroughViewModel.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 5.12.2023.
//

import UIComponents
import Utilities
import MobilliumUserDefaults

protocol WalkthroughViewDataSource {
    func numberOfItemsAt(section: Int) -> Int
    func cellItemAt(indexPath: IndexPath) -> WalkthroughCellProtocol
}

protocol WalkthroughViewEventSource {}

protocol WalkthroughViewProtocol: WalkthroughViewDataSource, WalkthroughViewEventSource {}

final class WalkthroughViewModel: BaseViewModel<WalkthroughRouter>, WalkthroughViewProtocol {
    
    private var cellItems : [WalkthroughCellProtocol] = [WalkthroughCellModel(image: Asset.Images.imgIntro1.image,
                                                                          titleText: L10n.Modules.WalkThrough.firstTitle,
                                                                          descriptionText: L10n.Modules.WalkThrough.descriptionText),
                                                     WalkthroughCellModel(image: Asset.Images.imgIntro2.image,
                                                                          titleText: L10n.Modules.WalkThrough.secondTitle,
                                                                          descriptionText: L10n.Modules.WalkThrough.descriptionText),
                                                     WalkthroughCellModel(image: Asset.Images.imgIntro3.image,
                                                                          titleText: L10n.Modules.WalkThrough.thirdTitle,
                                                                          descriptionText: L10n.Modules.WalkThrough.descriptionText),
                                                     WalkthroughCellModel(image: Asset.Images.imgIntro4.image,
                                                                          titleText: L10n.Modules.WalkThrough.fourthTitle,
                                                                          descriptionText: L10n.Modules.WalkThrough.descriptionText)]
    func numberOfItemsAt(section: Int) -> Int {
        cellItems.count
    }
    
    func cellItemAt(indexPath: IndexPath) -> UIComponents.WalkthroughCellProtocol {
        cellItems[indexPath.row]
    }
}

extension WalkthroughViewModel {
    func finishedIntro() {
        DefaultsKey.isIntroCompleted.value = true
        router.presentMainTabBar()
    }
}
