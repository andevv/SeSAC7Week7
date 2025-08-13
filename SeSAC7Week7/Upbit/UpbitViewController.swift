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
        viewModel.input.viewDidLoadTrigger.value = ()
        
        viewModel.output.marketData.bind {
            print("outputMarketData")
            self.tableView.reloadData()
        }
        
        viewModel.output.navigationTitleData.bind {
            print("outputNavTitleData")
            let value = self.viewModel.output.navigationTitleData.value
            self.navigationItem.title = value
        }
        
        //lazyBind 사용 또는 Optional(nil)일 때 실행되지 않도록 early exit
        viewModel.output.cellSelected.bind {
            print("outputCellSelected")
            print("output", self.viewModel.output.cellSelected.value)
            
            if self.viewModel.output.cellSelected.value.isEmpty {
                return
            }
            
            let vc = UpbitDetailViewController()
            vc.viewModel.outputTitle.value = self.viewModel.output.cellSelected.value
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
        return viewModel.output.marketData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let row = viewModel.output.marketData.value[indexPath.row]
        cell.textLabel?.text = row.overview
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        
        let row = viewModel.output.marketData.value[indexPath.row]
        
        viewModel.input.cellSelectedTrigger.value = row
    }
    
}
