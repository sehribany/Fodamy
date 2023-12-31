//
//  BaseViewModel.swift
//  Fodamy
//
//  Created by Şehriban Yıldırım on 5.12.2023.
//

import Foundation

protocol BaseViewDataSource:AnyObject {}

protocol BaseViewEventSource:AnyObject {
    var showActivityIndicatorView: VoidClosure? {get set}
    var hideActivityIndicatorView: VoidClosure? {get set}
    var showLoading              : VoidClosure? {get set}
    var hideLoading              : VoidClosure? {get set}
    var showWarningToast         : StringClosure? {get set}
}

protocol BaseViewModelProtocol: BaseViewDataSource, BaseViewEventSource {}

class BaseViewModel<R: Router>: BaseViewModelProtocol {
    
    let router                   : R
    var showActivityIndicatorView: VoidClosure?
    var hideActivityIndicatorView: VoidClosure?
    var showLoading              : VoidClosure?
    var hideLoading              : VoidClosure?
    var showWarningToast         : StringClosure?
    let dataProvider             : DataProviderProtocol

    
    init(router: R, dataProvider: DataProviderProtocol = apiDataProvider) {
        self.router       = router
        self.dataProvider = dataProvider
    }
}
