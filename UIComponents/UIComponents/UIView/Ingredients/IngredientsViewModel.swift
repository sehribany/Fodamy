//
//  IngredientsViewModel.swift
//  UIComponents
//
//  Created by Şehriban Yıldırım on 9.12.2023.
//

public protocol IngredientsViewDataSource: AnyObject {
    var numberOfPerson: String { get set}
    var ingredients   : String { get set}
}

public protocol IngredientsViewEventSource: AnyObject {}

public protocol IngredientsViewProtocol: IngredientsViewDataSource, IngredientsViewEventSource {}

public final class IngredientsViewModel: IngredientsViewProtocol {
    public var ingredients   : String
    public var numberOfPerson: String
    
    public init(ingredients: String, numberOfPerson: String) {
        self.ingredients    = ingredients
        self.numberOfPerson = numberOfPerson
    }
}
