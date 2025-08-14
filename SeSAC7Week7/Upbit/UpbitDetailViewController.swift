//
//  UpbitDetailViewController.swift
//  SeSAC7Week7
//
//  Created by andev on 8/12/25.
//

import UIKit

class UpbitDetailViewController: UIViewController {
    
    let viewModel = UpbitDetailViewModel()
    //var koreanData: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, "viewDidLoad")
        
        view.backgroundColor = .white
        
        //뷰컨트롤러로 로직을 옮기니 print가 되지 않음
        //bind로 전달한 함수를
        // -> 바로 실행도 하고, didSet action에 넣어둘지
        // -> 실행하지 않고 didSet action에 넣어둘지
        viewModel.outputTitle.bind { [weak self] in
            guard let self = self else { return }
            let data = self.viewModel.outputTitle.value
            self.navigationItem.title = data
            print("outputTitle Bind, \(data)")
        }

    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        print(self, "init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("UpbitDetailViewController: Deinit")
    }

}
