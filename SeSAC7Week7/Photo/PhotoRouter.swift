//
//  PhotoRouter.swift
//  SeSAC7Week7
//
//  Created by andev on 8/13/25.
//

import Foundation
import Alamofire

enum PhotoRouter {
    
    case one(id: Int)
    case list
    
    var baseURL: String {
        return "https://picsum.photos"
    }
    
    var endpoint: URL {
        switch self {
        case .one(let id):
            return URL(string: baseURL + "/id/\(id)/info")!
        case .list:
            return URL(string: baseURL + "/v2/list")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .one(let id):
            return ["":""]
        case .list:
            return ["page": "1", "limit": "20"]
        }
    }
    
//    var header: HTTPHeaders {
//        return ["Authorization": "Bearer \()"]
//    }
    
}
