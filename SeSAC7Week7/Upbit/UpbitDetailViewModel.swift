//
//  UpbitDetailViewModel.swift
//  SeSAC7Week7
//
//  Created by andev on 8/12/25.
//

import Foundation

final class UpbitDetailViewModel {
    
    var outputTitle: Observable<String?> = Observable(nil)
    
    init() {
        print("UpbitDetailView Init")
        print(outputTitle.value)
        
        outputTitle.bind {
            print("outputTitle Bind", self.outputTitle.value)
        }
    }
}
