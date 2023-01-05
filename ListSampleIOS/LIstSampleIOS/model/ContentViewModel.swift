//
//  HomeViewModel.swift
//  LIstSampleIOS
//
//  Created by Spud Hsu on 2023/1/5.
//

import Foundation
import Moya

class ContentViewModel: ObservableObject {
    private var provider = MoyaProvider<MessageService>()
    @Published var text: String = ""
    @Published var list: [Message] = []
    private var currentPage = 0
    private var loading = false
    private var hasMore = true
    private let decoder = JSONDecoder()
    init() {
        decoder.dateDecodingStrategy = .millisecondsSince1970
    }
    
    func addMessage() {
        let _text = text
        provider.request(.addMessage(message: _text)) { result in
            switch result {
                case let .success(value):
                    let model:AddMessageResponse = try! self.decoder.decode(AddMessageResponse.self, from: value.data)
                    self.list.insert(Message(id: model.id, content: _text, time: Date()), at:0)
                    self.text = ""
                case .failure(_):
                    print("fail")
            }
        }
    }
    
    func loadMoreMessages() {
        if (loading || !self.hasMore) {
            return
        }
        loading = true
        self.currentPage += 1
        print("load page \(self.currentPage)")
        provider.request(.getMessages(page: self.currentPage)) { result in
            switch result {
                case let .success(value):
                    let model:MessageResponse = try! self.decoder.decode(MessageResponse.self, from: value.data)
                    self.list = self.list + model.items
                    self.loading = false
                    self.hasMore = model.totalPages > self.currentPage
                case .failure(_):
                    print("fail")
                    self.loading = false
            }
        }
    }
}
