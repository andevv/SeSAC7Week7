//
//  LoginViewModel.swift
//  SeSAC7Week7
//
//  Created by andev on 8/11/25.
//

import Foundation

class LoginViewModel {
    
    //VC에서 들어온 이벤트
    var inputIdTextFieldText = Field("")
    
    var outputValidationLabel = Field("")
    var outputTextColor = Field(false)
    
    init() {
        print("LoginViewModel Init")
        
        inputIdTextFieldText.playAction { _ in
            self.vaildation()
        }
    }
    
    private func vaildation() {
        if inputIdTextFieldText.value.count < 4 {
            outputValidationLabel.value = "4자리 미만입니다"
            outputTextColor.value = false
        } else {
            outputValidationLabel.value = "잘했어요"
            outputTextColor.value = true
        }
    }
}
