//
//  MessageView.swift
//  LIstSampleIOS
//
//  Created by Spud Hsu on 2023/1/5.
//

import SwiftUI

struct MessageView: View {
    var message: Message
    let df = DateFormatter()
    var body: some View {
        VStack(alignment: .leading) {
            let _ = df.dateFormat = "YYYY-MM-dd HH:mm:ss"
            Text((message.content ?? "") + " #" + String(message.id))
                .font(.system(size: 24, weight: .medium))
                .multilineTextAlignment(.leading)
            Spacer(minLength: 5)
            Text(df.string(from: message.time))
                .multilineTextAlignment(.leading)
        }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message:
                        Message(id: 1, content: "aadda", time: Date()))
    }
}
