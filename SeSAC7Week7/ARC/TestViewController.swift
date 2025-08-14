//
//  TestViewController.swift
//  SeSAC7Week7
//
//  Created by andev on 8/14/25.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("TestViewController: ViewDidLoad")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        print("TestViewController: Init")
    }
    deinit {
        print("TestViewController: Deinit")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc = TestDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
