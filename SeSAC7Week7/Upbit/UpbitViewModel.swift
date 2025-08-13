//
//  UpbitViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation

final class UpbitViewModel {
    
    struct Input {
        var cellSelectedTrigger: Observable<Upbit?> = Observable(nil)
        var viewDidLoadTrigger: Observable<Void> = Observable(())
    }
    
    struct Output {
        var marketData: Observable<[Upbit]> = Observable([])
        var navigationTitleData = Observable("")
        var cellSelected: Observable<String> = Observable("")
    }
    
    var input: Input
    var output: Output
    
    init() {
        
        input = Input()
        output = Output()
        
        input.cellSelectedTrigger.bind {
            print("ViewModel inputCellSelectedTrigger")
            print(self.input.cellSelectedTrigger.value)
            self.output.cellSelected.value = self.input.cellSelectedTrigger.value?.korean_name ?? ""
        }
        
        input.viewDidLoadTrigger.lazyBind {
            print("ViewModel inputViewDidLoadTrigger")
            
            self.callRequest()
        }
    }
    
    func callRequest() {
        UpbitManager.shared.callRequest { market, title in
            self.output.marketData.value = market
            self.output.navigationTitleData.value = title
        }
    }
}
