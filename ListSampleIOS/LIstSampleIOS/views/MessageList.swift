//
//  MessageList.swift
//  LIstSampleIOS
//
//  Created by Spud Hsu on 2023/1/5.
//

import SwiftUI

struct MessageList: View {
    var list: [Message]
    var onLoadMore: () -> Void
    
    
    var body: some View {
        List(list) { item in
            MessageView(message: item)
            .onAppear {
                if (self.list.last?.id == item.id) {
                    print("load more")
                    onLoadMore()
                }
            }
        }.onAppear {
            onLoadMore()
        }
    }
}

struct MessageList_Previews: PreviewProvider {
    static var previews: some View {
        let messages: [Message] = [
            Message(id: 1, content: "aaccc", time: Date()),
            Message(id: 2, content: "bbb", time: Date()),
        ]
        
        MessageList(list: messages, onLoadMore: {
            print("asd")
        })
    }
}
