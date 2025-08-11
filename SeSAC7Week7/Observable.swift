//
//  Observable.swift
//  SeSAC7Week7
//
//  Created by andev on 8/11/25.
//

import Foundation

class Field<T> {
    
    private var action: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("text didSet", oldValue, value)
            action?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
        print("Field Init")
    }
    
    func playAction(action: @escaping (T) -> Void) {
        print(#function, "START")
        action(value)
        self.action = action
        print(#function, "END")
    }
}
