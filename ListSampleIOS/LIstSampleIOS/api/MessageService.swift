//
//  MessageService.swift
//  LIstSampleIOS
//
//  Created by Spud Hsu on 2023/1/5.
//

import Foundation
import Moya

struct MessageResponse: Codable {
    let items: [Message]
    let totalPages: Int
    let currentPage: String
}

struct AddMessageResponse: Codable {
    let id: Int
}

enum MessageService {
    case getMessages(page:Int)
    case addMessage(message: String)
}

extension MessageService: TargetType {
    var task: Moya.Task {
        switch self {
            case .getMessages(let p): return .requestParameters(parameters: ["p": p], encoding: URLEncoding.queryString)
            case .addMessage(let message): return .requestParameters(parameters: ["content": message], encoding: URLEncoding(destination: .httpBody))
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    var baseURL: URL { URL(string: "http://127.0.0.1:8080")! }
    var path: String {
        switch self {
            case .getMessages(_):
                return "/message"
            case .addMessage(_):
                return "/message"
        }
    }
    var method: Moya.Method {
        switch self {
            case .getMessages(_):
                return .get
            case .addMessage(_):
                return .post
        }
    }
}
