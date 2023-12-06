//
//  PhotoBrowserDelegate.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 5.12.2023.
//

import SKPhotoBrowser

final class PhotoBrowserDelegate: SKPhotoBrowserDelegate {

    var willDismissAtPage: IntClosure?

    func willDismissAtPageIndex(_ index: Int) {
        if let didDismiss = willDismissAtPage {
            didDismiss(index)
        }
    }
}
