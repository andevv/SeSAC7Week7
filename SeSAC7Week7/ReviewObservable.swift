//
//  ReviewObservable.swift
//  SeSAC7Week7
//
//  Created by andev on 8/12/25.
//

import Foundation

class Observable<T> {
    
    private var action: (() -> Void)?
    
    var value: T {
        didSet {
            print("Observable didSet")
            action?()
        }
    }
    
    init(_ value: T) {
        print("Observable Init")
        self.value = value
    }
    
    func bind(action: @escaping () -> Void) {
        print("Observable Bind")
        action()    //어떤 상황에 필요할지, 필요하지 않은 순간은 언제일지
        self.action = action
    }
    
    func lazyBind(action: @escaping () -> Void) {
        print("Observable lazyBind")
        self.action = action
    }
}
