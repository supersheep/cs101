//
//  Network.swift
//  LIstSampleIOS
//
//  Created by Spud Hsu on 2023/1/5.
//

import Foundation
import Alamofire

class Network {
    static let BASE_URL = "http://127.0.0.1:8080"
    static let shared = Network()
    func get(path:String, params: Any) -> DataRequest  {
        return AF.request(Network.BASE_URL + path)
    }
    func post(path:String, params: Parameters?) -> DataRequest {
        return AF.request(Network.BASE_URL + path, method: .post, parameters: params, encoder: URLEncodedFormParameterEncoder.default)
    }
}
