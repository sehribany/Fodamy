//
//  ShareSheetRoute.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//
import UIKit

protocol ShareSheetRoute {
    func presentShareSheet(items: [Any])
}

extension ShareSheetRoute where Self: RouterProtocol {
    
    func presentShareSheet(items: [Any]) {
        let shareSheetController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        let transition           = ModalTransition()
        
        open(shareSheetController, transition: transition)
    }
}
