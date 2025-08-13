//
//  NetworkViewController.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/11/25.
//
import UIKit
import SnapKit
import Alamofire
import Kingfisher

struct User {
    let age = 10 //저장 프로퍼티, 인스턴스 프로퍼티
    static let name = "Jack" //저장 프로퍼티, (메타)타입 프로퍼티
}

class PicsumViewController: UIViewController {
    
    private let textField = UITextField()
    private let searchButton = UIButton()
    private let photoImageView = UIImageView()
    private let infoLabel = UILabel()
    
    private let listButton = UIButton()
    private let tableView = UITableView()
    
    private var photoList: [PhotoList] = []
    
    let viewModel = PhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        PhotoManager.shared.callRequest(api: .one(id: 10), type: Photo.self) { response in
            print("callRequest", response)
        }
        
        PhotoManager.shared.callRequest(api: .list, type: [PhotoList].self) { response in
            print("callRequest", response)
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        let jack = User()
        jack.age
        print(type(of: jack)) //User: 인스턴스의 타입
        
        User.self.name
        
        let sesac = User.self
        sesac.name
        print(type(of: sesac)) //User.Type -> 메타타입
        
        var nickname = "고래밥"
        print(nickname)
        print(type(of: nickname))
        
        var age = User()
        print(age)
        print(type(of: age))
        
        print(type(of: User.self))
        print(type(of: String.self))
        
        setupUI()
        setupConstraints()
        bindData()
    }
    
    func bindData() {
        
        viewModel.output.overview.bind {
            let data = self.viewModel.output.overview.value
            self.infoLabel.text = data
        }
        
        viewModel.output.image.lazyBind {
            if let url = self.viewModel.output.image.value {
                self.photoImageView.kf.setImage(with: url)
            }
        }
        
        viewModel.output.list.bind {
            self.tableView.reloadData()
        }
        
//        viewModel.output.photo.lazyBind {
//            print("viewModel.output.photo.bind")
//            print(self.viewModel.output.photo.value)
//            
//            guard let photo = self.viewModel.output.photo.value else {
//                print("photo가 nil인 상황")
//                return
//            }
//            self.updatePhotoInfo(photo)
//        }
    }
    
    @objc private func searchButtonTapped() {
        viewModel.input.searchButtonTapped.value = ()
        viewModel.input.text.value = textField.text
        
    }
    
    private func updatePhotoInfo(_ photo: Photo) {
        infoLabel.text = "작가: \(photo.author), 해상도: \(photo.width) x \(photo.height)"
        
        if let url = URL(string: photo.download_url) {
            photoImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        }
    }
    
    @objc private func listButtonTapped() {
        
        viewModel.input.fetchButtonTapped.value = ()
        
//        PhotoManager.shared.getPhotoList { photo in
//            self.photoList = photo
//            self.tableView.reloadData()
//        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension PicsumViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.list.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotoTableViewCell else {
            return UITableViewCell()
        }
        
        let photo = viewModel.output.list.value[indexPath.row]
        cell.configure(with: photo)
        return cell
    }
}

extension PicsumViewController {
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Picsum Photos"
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "0~100 사이의 숫자 입력"
        textField.keyboardType = .numberPad
        view.addSubview(textField)
        
        searchButton.setTitle("검색", for: .normal)
        searchButton.backgroundColor = .systemBlue
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.layer.cornerRadius = 8
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        view.addSubview(searchButton)
        
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.backgroundColor = .systemGray6
        photoImageView.layer.cornerRadius = 8
        photoImageView.clipsToBounds = true
        view.addSubview(photoImageView)
        
        infoLabel.text = "작가: - | 해상도: -"
        infoLabel.font = .systemFont(ofSize: 14, weight: .medium)
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        view.addSubview(infoLabel)
        
        listButton.setTitle("사진 목록 가져오기", for: .normal)
        listButton.backgroundColor = .systemGreen
        listButton.setTitleColor(.white, for: .normal)
        listButton.layer.cornerRadius = 8
        listButton.addTarget(self, action: #selector(listButtonTapped), for: .touchUpInside)
        view.addSubview(listButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: "PhotoCell")
        tableView.layer.cornerRadius = 8
        tableView.backgroundColor = .systemGray6
        view.addSubview(tableView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupConstraints() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(searchButton.snp.leading).offset(-12)
            make.height.equalTo(44)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(textField)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(60)
            make.height.equalTo(44)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(150)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        listButton.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(listButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }
    
}
