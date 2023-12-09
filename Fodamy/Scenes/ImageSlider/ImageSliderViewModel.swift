//
//  ImageSliderViewModel.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 8.12.2023.
//

import Foundation

public protocol ImageSliderViewDataSource: AnyObject {
    var cellItems: [ImageSliderCellProtocol] { get set }
    func numberOfItemsAt(section: Int) -> Int
    func cellItemAt(indexPath: IndexPath) -> ImageSliderCellProtocol
}

public protocol ImageSliderViewEventSource: AnyObject {}

public protocol ImageSliderViewProtocol: ImageSliderViewDataSource, ImageSliderViewEventSource {}

public final class ImageSliderViewModel: ImageSliderViewProtocol {
 
    public var cellItems : [ImageSliderCellProtocol]
    
    public init(cellItems: [ImageSliderCellProtocol]) {
        self.cellItems = cellItems
    }
    
    public func numberOfItemsAt(section: Int) -> Int {
        return cellItems.count
    }
    
    public func cellItemAt(indexPath: IndexPath) -> ImageSliderCellProtocol {
        return cellItems[indexPath.row]
    }
}
