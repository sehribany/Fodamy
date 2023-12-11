//
//  EmptyCellModel.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

public protocol EmptyCellDataSource: AnyObject {}

public protocol EmptyCellEventSource: AnyObject {}

public protocol EmptyCellProtocol: EmptyCellDataSource, EmptyCellEventSource {}

public final class EmptyCellModel: EmptyCellProtocol {}
