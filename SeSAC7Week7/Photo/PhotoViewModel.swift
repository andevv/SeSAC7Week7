//
//  PhotoViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation

final class PhotoViewModel {
    
    var input: Input
    var output: Output
    
    struct Input {
        var searchButtonTapped: Observable<Void> = Observable(())
        var text: Observable<String?> = Observable(nil)
        //사진 목록 가져오기
        var fetchButtonTapped: Observable<Void> = Observable(())
    }
    
    struct Output {
        //사진 리스트
        var list: Observable<[PhotoList]> = Observable([])
        
        var image: Observable<URL?> = Observable(nil)
        var overview: Observable<String> = Observable("작가: -, 해상도: -")
        
        //var photo: Observable<Photo?> = Observable(nil)
    }
    
    init() {
        input = Input()
        output = Output()
        
        transform()
    }
    
    private func transform() {
        input.searchButtonTapped.lazyBind {
            print("searchButtonTapped bind")
            self.getPhoto()
        }
        input.text.lazyBind {
            print("input text bind")
        }
        input.fetchButtonTapped.lazyBind {
            self.getPhotoList()
        }
    }
    
    private func getPhotoList() {
        PhotoManager.shared.getPhotoList(api: .list) { photo in
            self.output.list.value = photo
        }
    }
    
    private func getPhoto() {
        guard let text = input.text.value, let photoId = Int(text), photoId >= 0 && photoId <= 100 else {
            print("0~100 사이의 숫자를 입력해주세요.")
            return
        }
        PhotoManager.shared.getOnePhoto(api: .one(id: photoId)) { [weak self] photo in
            guard let self = self else { return }
            let data = "작가: \(photo.author), 해상도: \(photo.width) x \(photo.height)"
            self.output.overview.value = data
            
            let url = URL(string: photo.download_url)
            self.output.image.value = url
            
            
            //self.output.photo.value = photo
        }
        
    }
    
}
