//
//  UpbitViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation

final class UpbitViewModel {
    
    var inputCellSelectedTrigger: Observable<Upbit?> = Observable(nil)
    var inputViewDidLoadTrigger: Observable<Void> = Observable(())
        
    var outputMarketData: Observable<[Upbit]> = Observable([])
    var outputNavigationTitleData = Observable("")
    var outputCellSelected: Observable<String> = Observable("")
    
    init() {
        inputCellSelectedTrigger.bind {
            print("ViewModel inputCellSelectedTrigger")
            print(self.inputCellSelectedTrigger.value)
            self.outputCellSelected.value = self.inputCellSelectedTrigger.value?.korean_name ?? ""
        }
        
        inputViewDidLoadTrigger.lazyBind {
            print("ViewModel inputViewDidLoadTrigger")
            
            self.callRequest()
        }
    }
    
    func callRequest() {
        UpbitManager.shared.callRequest { market, title in
            self.outputMarketData.value = market
            self.outputNavigationTitleData.value = title
        }
    }
}
