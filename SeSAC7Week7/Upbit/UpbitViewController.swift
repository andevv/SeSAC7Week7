//
//  UpbitViewController.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import UIKit
import SnapKit

class UpbitViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "UserCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
      
    let viewModel = UpbitViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationItems()
        bindData()
    }
    
    func bindData() {
        viewModel.inputViewDidLoadTrigger.value = ()
        
        viewModel.outputMarketData.bind {
            print("outputMarketData")
            self.tableView.reloadData()
        }
        
        viewModel.outputNavigationTitleData.bind {
            print("outputNavTitleData")
            let value = self.viewModel.outputNavigationTitleData.value
            self.navigationItem.title = value
        }
        
        //lazyBind 사용 또는 Optional(nil)일 때 실행되지 않도록 early exit
        viewModel.outputCellSelected.bind {
            print("outputCellSelected")
            print("output", self.viewModel.outputCellSelected.value)
            
            if self.viewModel.outputCellSelected.value.isEmpty {
                return
            }
            
            let vc = UpbitDetailViewController()
            vc.viewModel.outputTitle.value = self.viewModel.outputCellSelected.value
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
         
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupNavigationItems() {
        navigationItem.title = "마켓 목록"
    }
}

extension UpbitViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputMarketData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let row = viewModel.outputMarketData.value[indexPath.row]
        cell.textLabel?.text = row.overview
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        
        let row = viewModel.outputMarketData.value[indexPath.row]
        
        viewModel.inputCellSelectedTrigger.value = row
    }
    
}
