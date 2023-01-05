//
//  ContentView.swift
//  LIstSampleIOS
//
//  Created by Spud Hsu on 2023/1/5.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(input: self.$viewModel.text) {
                self.viewModel.addMessage()
            }
            
            MessageList(list: viewModel.list, onLoadMore: {
                self.viewModel.loadMoreMessages()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ContentViewModel()
        let _ = viewModel.list = [Message(id: 1, content: "aaa", time: Date())]
        ContentView(viewModel: viewModel)
    }
}

struct HeaderView: View {
    @Binding var input: String;
    var action: () -> Void
    var body: some View {
        HStack(alignment: .center) {
            TextField("请输入", text: $input)
            Button("添加") {
                action()
            }
        }.padding(EdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24))
    }
}
