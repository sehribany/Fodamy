//
//  StepsViewModel.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

public protocol StepsViewDataSource: AnyObject {
    var timeOfRecipe: String { get set}
    var directions  : String { get set}
}

public protocol StepsViewEventSource: AnyObject {}

public protocol StepsViewProtocol: StepsViewDataSource, StepsViewEventSource {}

public final class StepsViewModel: StepsViewProtocol {
    public var directions  : String
    public var timeOfRecipe: String
    
    public init(directions: String, timeOfRecipe: String) {
        self.directions   = directions
        self.timeOfRecipe = timeOfRecipe
    }
}
