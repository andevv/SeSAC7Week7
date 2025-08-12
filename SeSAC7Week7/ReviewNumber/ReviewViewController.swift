//
//  ReviewViewController.swift
//  SeSAC7Week7
//
//  Created by andev on 8/12/25.
//

import UIKit

class ReviewViewModel {
    
    let text = Observable("안녕하세요")
    
    ///viewController보다 viewModel이 먼저 init될 수밖에 없다.
    ///즉, Observable의 didSet action에 기능이 들어간 상태
    
    init() {
        print("ReviewViewModel Init")
        
        text.bind {
            print("text bind")
        }
    }
}

class ReviewViewController: UIViewController {
    
    //let number = Observable(100)
    let viewModel = ReviewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        view.backgroundColor = .white
        
//        number.lazyBind {
//            print("number bind")
//            self.navigationItem.title = "\(self.number.value)"
//        }
//        number.value = 50
        
    }
}
