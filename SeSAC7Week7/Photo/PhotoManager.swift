//
//  PhotoManager.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/11/25.
//

import Foundation
import Alamofire

final class PhotoManager {
    
    static let shared = PhotoManager()
    
    private init() { }
    
    /*
     1. AF.request 메서드 하나를 활용할 수 없나?
     2. 요청 로직을 한 곳에서 관리할 수 없나?
     */
    
    //parameters -> 쿼리스트링 자리가 될 수도 있고, post에 HTTP Body 영역이 될 수도 있음
    
    func callRequest<T: Decodable>(api: PhotoRouter, type: T.Type, success: @escaping (T) -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString)).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func getOnePhoto(api: PhotoRouter, success: @escaping (Photo) -> Void) {
        
        AF.request(api.endpoint, method: api.method).responseDecodable(of: Photo.self) { response in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getPhotoList(api: PhotoRouter, success: @escaping ([PhotoList]) -> Void) {
        
        AF.request(api.endpoint, method: api.method).responseDecodable(of: [PhotoList].self) { response in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
