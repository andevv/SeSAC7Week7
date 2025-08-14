//
//  TestDetailViewController.swift
//  SeSAC7Week7
//
//  Created by andev on 8/14/25.
//

import UIKit

class TestDetailViewController: UIViewController {
    
    var nickname = "고래밥"
    
    lazy var test = { [weak self] in
        guard let self = self else { return }
        print("안녕하세요 저는 \(self.nickname)입니다.") //self 때문에 deinit이 되지 않는 상황
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("TestDetailViewController: ViewDidLoad")
        print(nickname)
        test()
        

    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        print("TestDetailViewController: Init")
    }
    
    deinit {
        print("TestDetailViewController: Deinit")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}
