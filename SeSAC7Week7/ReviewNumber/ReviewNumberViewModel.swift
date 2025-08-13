//
//  ReviewNumberViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation

final class ReviewNumberViewModel {
    
    var input: Input
    var output: Output
    
    struct Input {
        var amount: Observable<String?> = Observable(nil)
    }
    
    struct Output {
        var amount: Observable<String?> = Observable("")
    }
    
    init() {
        
        input = Input()
        output = Output()
        
        input.amount.bind {
            print("inputAmount 달라짐")
            
            //1.
            guard let text = self.input.amount.value else {
                print("nil인 상태")
                self.output.amount.value = "값을 입력해주세요"
                return
            }
            
            //2.
            if text.isEmpty {
                print("값을 입력해주세요")
                self.output.amount.value = "값을 입력해주세요"
                return
            }
            
            //3.
            guard let num = Int(text) else {
                print("숫자만 입력해주세요")
                self.output.amount.value = "숫자만 입력해주세요"
                return
            }
            
            //4.
            if num > 0, num <= 10000000 {
                let format = NumberFormatter()
                format.numberStyle = .decimal
                let wonResult = format.string(from: num as NSNumber)!
                print("₩" + wonResult)
                self.output.amount.value = "₩" + wonResult
            } else {
                print("1,000만원 이하를 입력해주세요.")
                self.output.amount.value = "1,000만원 이하를 입력해주세요"
            }
        }

    }
    
}
