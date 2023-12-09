//
//  SegmentioOptions+Extensions.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 7.12.2023.
//

import Segmentio

public extension SegmentioOptions {
    
    static func options() -> SegmentioOptions {
        let indicatorOptions           = SegmentioIndicatorOptions(type: .bottom, ratio: 0.32, height: 2, color: Asset.Colors.appRed.color)
        let horizontalSeparatorOptions = SegmentioHorizontalSeparatorOptions(type: .none, height: 0, color: .appWhite)
        let verticalSeparatorOptions   = SegmentioVerticalSeparatorOptions(ratio: 1, color: Asset.Colors.appZircon.color)
        
        let segmentStates              = SegmentioStates(defaultState: SegmentioState(backgroundColor: .clear,
                                                                                      titleFont: .font(.nunitoBold, size: .medium),
                                                                                      titleTextColor: Asset.Colors.appCinder.color),
                                                         selectedState: SegmentioState(backgroundColor: .clear,
                                                                                      titleFont: .font(.nunitoBold, size: .medium),
                                                                                      titleTextColor: Asset.Colors.appRed.color),
                                                         highlightedState: SegmentioState(backgroundColor: .clear,
                                                                                    titleFont: .font(.nunitoBold, size: .medium),
                                                                                    titleTextColor: Asset.Colors.appRed.color))
        
        let options                   = SegmentioOptions(backgroundColor: Asset.Colors.appWhite.color,
                                                         segmentPosition: .fixed(maxVisibleItems: 2),
                                                         scrollEnabled: false, indicatorOptions: indicatorOptions,
                                                         horizontalSeparatorOptions: horizontalSeparatorOptions,
                                                         verticalSeparatorOptions: verticalSeparatorOptions,
                                                         imageContentMode: .center,
                                                         labelTextAlignment: .center,
                                                         segmentStates: segmentStates)
        return options
    }
}
